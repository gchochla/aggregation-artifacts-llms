import os
import re

import gridparse
import pandas as pd

# TODO: save variance for plotting


def parse_args():
    parser = gridparse.ArgumentParser()
    parser.add_argument("--annotator-results-dir", nargs="+")
    parser.add_argument("--metric", type=str, default="jaccard_score")
    parser.add_argument("--output-dir", type=str, default=".")

    return parser.parse_args()


def main():
    args = parse_args()

    annotator_re = re.compile("ann-((\\d|[A-Za-z])+)")
    annotator_perf = {}
    annotator_sim = {}

    for annotator_results_dir in args.annotator_results_dir:
        results = pd.read_csv(
            os.path.join(annotator_results_dir, f"{args.metric}.csv"),
            index_col=0,
        )

        current_annotators = set()

        for k in results.index:
            match = annotator_re.match(k)
            if match:
                annotator = match.groups()[0]
                current_annotators.add(annotator)

        # find prior and ICL performance
        for annotator in current_annotators:
            annotator_index = f"ann-{annotator}"

            annotator_perf[annotator] = [
                float(
                    results["prior"][annotator_index + " (GT)"].split("\n")[0]
                ),
                float(
                    results[annotator_index][annotator_index + " (GT)"].split(
                        "\n"
                    )[0]
                ),
            ]

        current_annotators = list(current_annotators)

        # find similarity between annotators
        for i in range(len(current_annotators)):
            annotator1 = current_annotators[i]
            annotator_sim[f"{annotator1}-aggr"] = float(
                results[f"ann-{annotator1} (GT)"]["aggr (GT)"].split("\n")[0]
            )
            for j in range(i + 1, len(current_annotators)):
                annotator2 = current_annotators[j]

                if annotator1 == annotator2:
                    continue

                annotator_index1 = f"ann-{annotator1}"
                annotator_index2 = f"ann-{annotator2}"

                annotator_sim[f"{annotator1}-{annotator2}"] = float(
                    results[annotator_index1 + " (GT)"][
                        annotator_index2 + " (GT)"
                    ].split("\n")[0]
                )

    # add aggregate performance
    annotator_perf["aggr"] = [
        float(results["prior"]["aggr (GT)"].split("\n")[0]),
        float(results["aggr"]["aggr (GT)"].split("\n")[0]),
    ]

    annotator_perf = {
        k: [v[0], v[1], v[1] - v[0], (v[1] - v[0]) / (v[0] + 1e-6)]
        for k, v in annotator_perf.items()
    }

    # save to csv

    os.makedirs(args.output_dir, exist_ok=True)

    annotator_perf_df = pd.DataFrame.from_dict(
        annotator_perf,
        orient="index",
        columns=["prior", "post", "delta", "delta_pct"],
    )
    annotator_perf_df.to_csv(
        os.path.join(args.output_dir, f"{args.metric}_improvement.csv")
    )

    annotator_sim_df = pd.DataFrame.from_dict(
        annotator_sim,
        orient="index",
        columns=["similarity"],
    )

    annotator_sim_df.to_csv(
        os.path.join(args.output_dir, f"{args.metric}_similarity.csv")
    )


if __name__ == "__main__":
    main()
