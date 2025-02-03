"""python scripts/annotator-pull/annotator_hunting.py MFRC --root-dir /data/chochlak/mfrc --train-split train --test-split dev test --annotation-mode annotator"""

import traceback
import gridparse
from legm import splitify_namespace
from legm.argparse_utils import add_arguments

from llm_subj import (
    GoEmotionsDataset,
    MFRCDataset,
    CONSTANT_ARGS,
)
from llm_subj.utils import clean_cuda


DATASET = dict(
    GoEmotions=GoEmotionsDataset,
    MFRC=MFRCDataset,
)


def parse_args():
    parser = gridparse.GridArgumentParser()
    sp = parser.add_subparsers(dest="task")

    for task in DATASET:
        sp_task = sp.add_parser(task)
        args = DATASET[task].argparse_args()
        args.pop("debug_ann")
        add_arguments(sp_task, args, replace_underscores=True)
        add_arguments(sp_task, CONSTANT_ARGS, replace_underscores=True)
        sp_task.add_argument(
            "--train-debug-anns",
            type=str,
            nargs="*",
            help="annotators to use for training",
        )

    return parser.parse_args()


# make its own function to avoid memory leaks
def loop(args):
    print("\nCurrent setting: ", args.train_debug_ann, "\n")

    train_dataset = DATASET[args.task](
        init__namespace=splitify_namespace(args, "train")
    )
    annotations = train_dataset.annotations
    triplets = []

    for i in range(len(annotations)):
        ann1 = list(annotations.keys())[i]
        for j in range(i + 1, len(annotations)):
            ann2 = list(annotations.keys())[j]
            common = set(annotations[ann1]) & set(annotations[ann2])
            for k in range(j + 1, len(annotations)):
                ann3 = list(annotations.keys())[k]

                common_k = common & set(annotations[ann3])
                if len(common_k) > 150:
                    print(
                        f"Annotators {i}-{j}-{k} have {len(common_k)} common examples"
                    )
                    triplets.append((ann1, i, ann2, j, ann3, k))

    test_dataset = DATASET[args.task](
        init__namespace=splitify_namespace(args, "test"),
        annotator_ids=train_dataset.annotators,
    )

    annotations = test_dataset.annotations
    for ann1, i, ann2, j, ann3, k in triplets:
        common = (
            set(annotations[ann1])
            & set(annotations[ann2])
            & set(annotations[ann3])
        )
        if len(common) > 50:
            print(
                f"Annotators {i}-{j}-{k} have {len(common)} common examples in the test set"
            )

    print(
        "Train examples: ",
        len(list(train_dataset.annotations.values())[0]),
    )
    print(
        "Test examples: ",
        len(list(test_dataset.annotations.values())[0]),
    )


def main():
    args = parse_args()[0]
    anns = args.train_debug_anns or [None]
    for ann in anns:
        args.train_debug_ann = [int(e) for e in ann.split("-")] if ann else None
        try:
            loop(args)
        except Exception as e:
            print("\n\n\nError:", traceback.format_exc())
            print("\n\n\nContinuing...\n\n\n")
            clean_cuda()


if __name__ == "__main__":
    main()
