import os
import sys
import yaml
import re

import matplotlib.pyplot as plt
import numpy as np


METRICS = ["jaccard_score", "micro_f1", "macro_f1"]
MODELS = [
    "meta-llama--Llama-2-7b-chat-hf",
    "meta-llama--Meta-Llama-3-8B-Instruct",
    "meta-llama--Llama-2-70b-chat-hf",
    "meta-llama--Meta-Llama-3-70B-Instruct",
    "gpt-3.5-turbo",
    "gpt-4o-mini-2024-07-18",
]
DATASET_NAMES = ["MFRC", "GoEmotions"]


def baselines(analyses_folder, log_folder, basename=None, aggr=False):

    if isinstance(aggr, str):
        aggr = aggr.lower() == "true"

    def read_scores(experiment_folder, model, cot=False, ann=None):
        if "gpt" in model.lower():
            experiment_folder = os.path.abspath(experiment_folder) + "OpenAI"

        shot = 45 if not cot else 15

        if aggr:
            file = "aggregated_metrics.yml"
        else:
            file = "aggregated_annotator_metrics.yml"

        with open(
            os.path.join(
                experiment_folder,
                (
                    f"{model}-annotator-{aggr}-None-{shot}-shot_0"
                    if not cot
                    else f"{model}-cot-annotator-{aggr}-None-{shot}-shot_0"
                ),
                file,
            )
        ) as fp:
            data = yaml.safe_load(fp)[""]

        if not aggr:
            if ann:
                data = data[ann]
            else:
                ann = next(iter(data))
                data = data[ann]

        def process_metric(metric):
            if "+" in metric:
                return float(metric.split("+")[0])
            elif "±" in metric:
                return float(metric.split("±")[0])

        if "4o" in model:
            model = "gpt-4o-mini"

        return {
            model: {
                "JS": process_metric(
                    data.get("test_jaccard_score", data.get("jaccard_score"))
                ),
                "Mic": process_metric(
                    data.get("test_micro_f1", data.get("micro_f1"))
                ),
                "Mac": process_metric(
                    data.get("test_macro_f1", data.get("macro_f1"))
                ),
            }
        }, ann

    results = {k: {} for k in DATASET_NAMES}
    results_cot = {k: {} for k in DATASET_NAMES}
    height_range = {k: [float("inf"), -float("inf")] for k in DATASET_NAMES}

    anns = {}
    for dataset in DATASET_NAMES:
        anns[dataset] = None
        for model in MODELS:
            r, anns[dataset] = read_scores(
                os.path.join(log_folder, dataset),
                model,
                ann=anns[dataset],
            )
            results[dataset].update(r)
            r, anns[dataset] = read_scores(
                os.path.join(log_folder, dataset),
                model,
                cot=True,
                ann=anns[dataset],
            )
            results_cot[dataset].update(r)

    results["MFRC"].update({"Demux": {"JS": 0.828, "Mic": 0.555, "Mac": 0.503}})
    results["GoEmotions"].update(
        {"Demux": {"JS": 0.661, "Mic": 0.702, "Mac": 0.692}},
    )

    for dataset in results:
        for model in results[dataset]:
            for metric in results[dataset][model]:
                if results[dataset][model][metric] is not None:
                    height_range[dataset][0] = min(
                        height_range[dataset][0],
                        results[dataset][model][metric],
                    )
                    height_range[dataset][1] = max(
                        height_range[dataset][1],
                        results[dataset][model][metric],
                    )
                if (
                    model != "Demux"
                    and results_cot[dataset][model][metric] is not None
                ):
                    height_range[dataset][0] = min(
                        height_range[dataset][0],
                        results_cot[dataset][model][metric],
                    )
                    height_range[dataset][1] = max(
                        height_range[dataset][1],
                        results_cot[dataset][model][metric],
                    )

    n_results = len(MODELS) + 1

    # bar plot comparing the strength of the prior to the ground truth
    # compare for each dataset, all the models for every metric at different shots
    fig, ax = plt.subplots(
        len(DATASET_NAMES),
        1,
        figsize=(6, 3),
        sharex=True,
    )

    barwidth = 0.04
    colors = [
        "skyblue",
        "limegreen",
        "orange",
        "violet",
        "red",
        "peru",
        "dimgray",
    ]
    assert len(colors) >= n_results

    for j, dataset in enumerate(results):
        for k, model in enumerate(results[dataset]):
            # for i, metric in enumerate(results[dataset][model]):
            # nested_x_value is models
            # x_value is metric

            pos = np.arange(len(METRICS)) * (n_results + 3) * barwidth

            if results[dataset][model]["JS"] is not None:
                if j == 0:
                    if k == len(results[dataset]) - 1:
                        ax[j].bar(
                            pos + k * barwidth,
                            results[dataset][model].values(),
                            barwidth,
                            label=(
                                model.split("--")[1] if "--" in model else model
                            ),
                            color=colors[k],
                            edgecolor="black",
                        )
                    else:
                        ax[j].bar(
                            pos + k * barwidth - barwidth / 2,
                            results[dataset][model].values(),
                            barwidth / 2,
                            label=(
                                model.split("--")[1] if "--" in model else model
                            ),
                            color=colors[k],
                            edgecolor="black",
                        )

                        ax[j].bar(
                            pos + k * barwidth,
                            results_cot[dataset][model].values(),
                            barwidth / 2,
                            color=colors[k],
                            edgecolor="black",
                            hatch="///",
                        )
                else:
                    if k == len(results[dataset]) - 1:
                        ax[j].bar(
                            pos + k * barwidth,
                            results[dataset][model].values(),
                            barwidth,
                            color=colors[k],
                            edgecolor="black",
                        )
                    else:
                        ax[j].bar(
                            pos + k * barwidth - barwidth / 2,
                            results[dataset][model].values(),
                            barwidth / 2,
                            color=colors[k],
                            edgecolor="black",
                        )

                        ax[j].bar(
                            pos + k * barwidth,
                            results_cot[dataset][model].values(),
                            barwidth / 2,
                            color=colors[k],
                            edgecolor="black",
                            hatch="///",
                        )

        ax[j].grid(axis="y", linestyle="dashed")

        if anns.get(next(iter(results)), None):
            ann = anns[DATASET_NAMES[j]]
            ann = re.sub(r"\D", "", ann)
            ax[j].set_ylabel(
                f"{DATASET_NAMES[j]} ({ann})", labelpad=10, fontsize=10
            )
        else:
            ax[j].set_ylabel(DATASET_NAMES[j], labelpad=10, fontsize=10)

        ax[j].set_xticks(
            # move to middle of whole current section of nested_x_values + gap for each
            # y_axis value, adjust one bar back because starting after the first bar
            barwidth * ((n_results + 1) / 2 - 1)
            + pos
        )

        ax[j].set_xticklabels(["Jaccard Score", "Micro F1", "Macro F1"])

        ax[j].set_ylim(
            top=height_range[dataset][1] * 1.03,
            bottom=height_range[dataset][0] * 0.97,
        )

    ax[0].bar(
        pos,
        [0, 0, 0],
        barwidth,
        color="white",
        edgecolor="black",
        hatch="///",
        label="CoT",
    )

    fig.suptitle("")
    plt.subplots_adjust(top=0.7)
    fig.legend(
        loc="upper center",
        fontsize=8,
        bbox_to_anchor=(0.52, 1.05),
        ncol=4,
        frameon=False,
    )

    plt.tight_layout()
    plt.savefig(
        os.path.join(
            analyses_folder,
            basename or f"baselines.pdf",
        ),
        bbox_inches="tight",
    )


def annotator(analyses_folder, log_folder, basename=None):

    def read_scores(experiment_folder, model, ann=None):
        if "gpt" in model.lower():
            experiment_folder = os.path.abspath(experiment_folder) + "OpenAI"

        shot = 45

        if not ann:
            file = "aggregated_metrics.yml"
        else:
            file = "aggregated_annotator_metrics.yml"

        try:
            with open(
                os.path.join(
                    experiment_folder,
                    f"{model}-annotator-{not ann}-None-{shot}-shot_0",
                    file,
                )
            ) as fp:
                data = yaml.safe_load(fp)[""]

            if ann:
                data = data[ann]
        except:
            with open(
                os.path.join(
                    experiment_folder,
                    f"{model}-annotator-{not ann}-None-{shot}-shot_1",
                    file,
                )
            ) as fp:
                data = yaml.safe_load(fp)[""]

            if ann:
                data = data[ann]

        def process_metric(metric):
            if "+" in metric:
                return float(metric.split("+")[0])
            elif "±" in metric:
                return float(metric.split("±")[0])

        if "4o" in model:
            model = "gpt-4o-mini"

        return {
            model: {
                "JS": process_metric(
                    data.get("test_jaccard_score", data.get("jaccard_score"))
                ),
                "Mic": process_metric(
                    data.get("test_micro_f1", data.get("micro_f1"))
                ),
                "Mac": process_metric(
                    data.get("test_macro_f1", data.get("macro_f1"))
                ),
            }
        }, ann

    results = {k: {} for k in DATASET_NAMES}
    results_ann = {k: {} for k in DATASET_NAMES}
    height_range = {k: [float("inf"), -float("inf")] for k in DATASET_NAMES}

    anns = {"MFRC": "annotator01", "GoEmotions": "60"}
    for dataset in DATASET_NAMES:
        for model in MODELS:
            r, _ = read_scores(
                os.path.join(log_folder, dataset),
                model,
            )
            results[dataset].update(r)
            r, _ = read_scores(
                os.path.join(log_folder, dataset),
                model,
                ann=anns[dataset],
            )
            results_ann[dataset].update(r)

    for dataset in results:
        for model in results[dataset]:
            for metric in results[dataset][model]:
                if results[dataset][model][metric] is not None:
                    height_range[dataset][0] = min(
                        height_range[dataset][0],
                        results[dataset][model][metric],
                    )
                    height_range[dataset][1] = max(
                        height_range[dataset][1],
                        results[dataset][model][metric],
                    )
                if results_ann[dataset][model][metric] is not None:
                    height_range[dataset][0] = min(
                        height_range[dataset][0],
                        results_ann[dataset][model][metric],
                    )
                    height_range[dataset][1] = max(
                        height_range[dataset][1],
                        results_ann[dataset][model][metric],
                    )

    n_results = len(MODELS) + 1

    # bar plot comparing the strength of the prior to the ground truth
    # compare for each dataset, all the models for every metric at different shots
    fig, ax = plt.subplots(
        len(DATASET_NAMES),
        1,
        figsize=(6, 3),
        sharex=True,
    )

    barwidth = 0.04
    colors = [
        "skyblue",
        "limegreen",
        "orange",
        "violet",
        "red",
        "peru",
        "dimgray",
    ]
    assert len(colors) >= n_results

    for j, dataset in enumerate(results):
        for k, model in enumerate(results[dataset]):
            # for i, metric in enumerate(results[dataset][model]):
            # nested_x_value is models
            # x_value is metric

            pos = np.arange(len(METRICS)) * (n_results + 3) * barwidth

            if results[dataset][model]["JS"] is not None:
                if j == 0:
                    ax[j].bar(
                        pos + k * barwidth - barwidth / 2,
                        results[dataset][model].values(),
                        barwidth / 2,
                        label=(
                            model.split("--")[1] if "--" in model else model
                        ),
                        color=colors[k],
                        edgecolor="black",
                    )

                    ax[j].bar(
                        pos + k * barwidth,
                        results_ann[dataset][model].values(),
                        barwidth / 2,
                        color=colors[k],
                        edgecolor="black",
                        hatch="///",
                    )
                else:
                    ax[j].bar(
                        pos + k * barwidth - barwidth / 2,
                        results[dataset][model].values(),
                        barwidth / 2,
                        color=colors[k],
                        edgecolor="black",
                    )

                    ax[j].bar(
                        pos + k * barwidth,
                        results_ann[dataset][model].values(),
                        barwidth / 2,
                        color=colors[k],
                        edgecolor="black",
                        hatch="///",
                    )

        ax[j].grid(axis="y", linestyle="dashed")

        if anns.get(next(iter(results)), None):
            ax[j].set_ylabel(DATASET_NAMES[j], labelpad=10, fontsize=10)
        else:
            ax[j].set_ylabel(DATASET_NAMES[j], labelpad=10, fontsize=10)

        ax[j].set_xticks(
            # move to middle of whole current section of nested_x_values + gap for each
            # y_axis value, adjust one bar back because starting after the first bar
            barwidth * ((n_results + 1) / 2 - 1)
            + pos
        )

        ax[j].set_xticklabels(["Jaccard Score", "Micro F1", "Macro F1"])

        ax[j].set_ylim(
            top=height_range[dataset][1] * 1.03,
            bottom=height_range[dataset][0] * 0.97,
        )

    ax[0]

    fig.suptitle("")
    plt.subplots_adjust(top=0.7)
    fig.legend(
        loc="upper center",
        fontsize=8,
        bbox_to_anchor=(0.555, 1.05),
        ncol=3,
        frameon=False,
    )

    l, *_ = ax[0].bar(
        pos,
        [0, 0, 0],
        barwidth,
        color="white",
        edgecolor="black",
        hatch="///",
        label="Annotator 01",
    )
    ax[0].legend(handles=[l], labels=["Annotator 01"])
    ax[1].bar(
        pos,
        [0, 0, 0],
        barwidth,
        color="white",
        edgecolor="black",
        hatch="///",
        label="Annotator 60",
    )
    ax[1].legend()

    plt.tight_layout()
    plt.savefig(
        os.path.join(
            analyses_folder,
            basename or f"baselines.pdf",
        ),
        bbox_inches="tight",
    )


if __name__ == "__main__":
    script = sys.argv[1]
    globals()[script](*sys.argv[2:])
