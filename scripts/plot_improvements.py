"""Plot improvements of original annotators as a function of the similarity to the prior."""

import os

import gridparse
import scipy.stats as stats
import pandas as pd
import matplotlib.pyplot as plt
import matplotlib.ticker as mtick
from sklearn.linear_model import LinearRegression


def parse_args():
    parser = gridparse.ArgumentParser(
        description='Plot improvements on scatter plot'
    )
    parser.add_argument(
        "--input",
        type=str,
        nargs="+",
        required=True,
        help="Input folders (containing one csv of improvements and one of similarity)",
    )
    parser.add_argument(
        "--name",
        type=str,
        nargs="+",
        help="Col name(s)",
    )
    parser.add_argument(
        "--output",
        type=str,
        required=True,
        help="Output folder",
    )
    parser.add_argument(
        "--row-name",
        type=str,
        nargs="+",
        help="Row name(s)",
    )
    parser.add_argument(
        "--row-metric",
        type=str,
        nargs="+",
        help="Row metric(s)",
    )
    parser.add_argument(
        "--type",
        type=str,
        choices=["prior", "aggr", "prior-abs", "aggr-abs", "prior-aggr"],
        default="prior",
        help="Type of similarity to use",
    )
    parser.add_argument(
        "--title",
        type=str,
        help="Title for the plot",
    )
    parser.add_argument(
        "--diff-markers",
        action="store_true",
        help="Use different markers for each annotator",
    )
    parser.add_argument(
        "--fn-suffix",
        type=str,
        help="Suffix for the filenames",
    )

    return parser.parse_args()


COLORS = ["skyblue", "limegreen", "dimgray", "violet", "red", "peru", "orange"]
MARKERS = ["o", "D", "v", "^", ">", "<", "p", "P", "s"]


# TODO: to add titles in every row, look at this:
# https://stackoverflow.com/questions/27426668/row-titles-for-matplotlib-subplot
def main():
    args = parse_args()
    args.fn_suffix = (
        args.fn_suffix if args.fn_suffix and args.fn_suffix != "None" else None
    )

    assert (
        not args.name
        or (not args.row_name and len(args.input) % len(args.name) == 0)
        or (
            args.row_name
            and len(args.input) == len(args.row_name) * len(args.name)
        )
    )

    os.makedirs(args.output, exist_ok=True)

    nrows = len(args.input) // len(args.name) if args.name else 1
    ncols = len(args.name) if args.name else len(args.input)

    colors = [{} for i in range(nrows)]
    markers = [{} for i in range(nrows)]

    coll_fg, coll_ax = plt.subplots(
        nrows=nrows, ncols=ncols, figsize=(2.5 * ncols, 2 * nrows)
    )

    thres_pval = 0.15  # heuristic: threshold for significant correlation taking into account 3 seeds

    for i, folder in enumerate(args.input):

        if args.row_metric:
            if len(args.row_metric) == 1:
                row_metric = args.row_metric[0]
            else:
                row_metric = args.row_metric[i // len(args.name)]
        else:
            row_metric = "jaccard_score"

        improvements = pd.read_csv(
            os.path.join(folder, f"{row_metric}_improvement.csv"), index_col=0
        )
        ids = improvements.index.values.tolist()
        similarities = pd.read_csv(
            os.path.join(folder, f"{row_metric}_similarity.csv"), index_col=0
        )

        if args.type == "prior-aggr":
            xs = similarities["similarity"]
            ys = improvements["prior"]
            # annotator1-aggr
            xs_index = xs.index.values.tolist()
            # annotator1
            ys_index = ys.index.values.tolist()
            x_inds = []
            y_inds = []
            for ii, idx in enumerate(ys_index):
                if idx == "aggr":
                    continue
                x_inds.append(xs_index.index(idx + "-aggr"))
                y_inds.append(ii)

            ids.remove("aggr")
            xs = xs.iloc[x_inds]
            ys = ys.iloc[y_inds]
        elif args.type == "prior":
            xs = improvements["prior"]
            ys = improvements["delta_pct"] * 100
        elif args.type == "prior-abs":
            xs = improvements["prior"]
            ys = improvements["post"]
        elif args.type == "aggr":
            xs = similarities["similarity"]
            ys = improvements["delta_pct"] * 100
            # annotator1-aggr
            xs_index = xs.index.values.tolist()
            # annotator1
            ys_index = ys.index.values.tolist()
            x_inds = []
            y_inds = []
            for ii, idx in enumerate(ys_index):
                if idx == "aggr":
                    continue
                x_inds.append(xs_index.index(idx + "-aggr"))
                y_inds.append(ii)

            ids.remove("aggr")
            xs = xs.iloc[x_inds]
            ys = ys.iloc[y_inds]
        elif args.type == "aggr-abs":
            xs = similarities["similarity"]
            ys = improvements["post"]
            # annotator1-aggr
            xs_index = xs.index.values.tolist()
            # annotator1
            ys_index = ys.index.values.tolist()
            x_inds = []
            y_inds = []
            for ii, idx in enumerate(ys_index):
                if idx == "aggr":
                    continue
                x_inds.append(xs_index.index(idx + "-aggr"))
                y_inds.append(ii)

            xs = xs.iloc[x_inds]
            ys = ys.iloc[y_inds]

        model = LinearRegression().fit(xs.values.reshape(-1, 1), ys.values)
        corr, pval = stats.pearsonr(xs, ys)
        # corr_aggr, pval_aggr = stats.pearsonr(xs.drop("aggr"), ys.drop("aggr"))

        fg, ax = plt.subplots()

        ax.scatter(xs, ys)
        if args.type in ("prior", "prior-abs"):
            aggr_idx = improvements.index.values.tolist().index("aggr")
            ax.scatter(
                xs.values[aggr_idx],
                ys.values[aggr_idx],
                color="orange",
                label="Aggregate",
            )

        ax.plot(
            xs,
            model.predict(xs.values.reshape(-1, 1)),
            color="red",
            label=f"ρ = {corr:.2f}" + ("$^*$" if pval <= thres_pval else ""),
            # + (u"$^\u2021$" if pval_aggr <= thres_pval else ""),
        )
        ax.set_xlabel(
            "Similarity with Aggregate ("
            + row_metric.replace("_", " ").title()
            + ")"
        )
        ax.set_ylabel("Relative Posterior Improvement")
        name = args.name[i % len(args.name)] if args.name else folder
        row_name = args.row_name[i // len(args.name)] if args.row_name else None
        ax.set_title(name)
        if args.type in ("prior", "aggr"):
            ax.yaxis.set_major_formatter(mtick.PercentFormatter())
        fg.legend()
        fg.tight_layout()
        fg.savefig(
            os.path.join(
                args.output,
                (
                    f"{name}.png"
                    if not row_name
                    else f"{row_name}-{name}-{args.type}.png"
                ),
            )
        )
        fg.clf()

        if args.name and len(args.name) != len(args.input):
            row = i // ncols
            col = i % ncols
            ax = coll_ax[row, col]

            if col == 0 and args.row_name:
                ax.set_ylabel(args.row_name[row], labelpad=13, fontsize=10)

            if row == 0:
                ax.set_title(name)
        else:
            ax = coll_ax[i]
            ax.set_title(name)

        if args.type in ("prior", "aggr"):
            ax.yaxis.set_major_formatter(mtick.PercentFormatter())

        if not colors[row]:
            if args.diff_markers:
                colors[row] = {id: COLORS[i] for i, id in enumerate(ids)}
            else:
                colors[row] = {id: COLORS[2] for id in ids}
            colors[row]["aggr"] = "orange"
        if not markers[row]:
            if args.diff_markers:
                markers[row] = {id: MARKERS[i] for i, id in enumerate(ids)}
            else:
                markers[row] = {id: MARKERS[1] for id in ids}
            markers[row]["aggr"] = "s"
        for x, y, id in zip(xs, ys, ids):
            ax.scatter(x, y, marker=markers[row][id], c=colors[row][id])

        if args.type in ("prior", "prior-abs"):
            ax.scatter(
                xs.values[aggr_idx],
                ys.values[aggr_idx],
                color="orange",
                marker=markers[row]["aggr"],
            )
        ax.plot(
            xs,
            model.predict(xs.values.reshape(-1, 1)),
            color="red" if model.coef_[0] < 0 else "green",
            linewidth=4 if pval <= thres_pval else 0.5,
            label=f"ρ = {corr:.2f}" + ("$^*$" if pval <= thres_pval else ""),
            # + (u"$^\u2021$" if pval_aggr <= thres_pval else ""),
        )
        ax.legend()
        leg = ax.legend(handlelength=0, handletextpad=0, fancybox=True)
        for item in leg.legend_handles:
            item.set_visible(False)

    title = args.title or (
        "Relative Posterior Improvement of Annotators"
        if args.type in ("aggr", "prior")
        else (
            "Annotator Performance"
            if args.type in ("aggr-abs", "prior-abs")
            else (
                "Annotator Similarity to Prior vs Annotator Similarity to Aggregate"
            )
        )
    )
    xlabel = (
        "Annotator Similarity with Aggregate"
        if args.type in ("aggr", "aggr-abs")
        else (
            "Annotator Similarity with Prior"
            if args.type in ("prior", "prior-abs")
            else ""
        )
    )

    coll_fg.suptitle(title, fontsize=16)
    # coll_fg.supylabel("Relative Posterior Improvement")
    if xlabel:
        coll_fg.supxlabel(xlabel)

    # get dummy artist for legend
    if args.type == "prior":
        a = ax.scatter(
            xs.values[aggr_idx], ys.values[aggr_idx], color="orange", marker="s"
        )
        coll_fg.legend([a], ["Aggregate"])
    coll_fg.tight_layout()
    fn = f"all-{args.type}" + (f"-{args.fn_suffix}" if args.fn_suffix else "")
    pdf_fn = os.path.join(args.output, f"{fn}.pdf")
    png_fn = os.path.join(args.output, f"{fn}.png")
    coll_fg.savefig(pdf_fn)
    coll_fg.savefig(png_fn)
    coll_fg.clf()

    # print(colors, markers)


if __name__ == "__main__":
    main()
