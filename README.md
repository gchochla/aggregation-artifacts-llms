# [NAACL'25] Aggregation Artifacts in Subjective Tasks Collapse Large Language Models' Posteriors

This repo contains the official implementation of [Aggregation Artifacts in Subjective Tasks Collapse Large Language Models' Posteriors](https://arxiv.org/abs/2410.13776), published in the Proceedings of NAACL 2025.

## Abstract

> In-context Learning (ICL) has become the primary method for performing natural language tasks with Large Language Models (LLMs). The knowledge acquired during pre-training is crucial for this few-shot capability, providing the model with task priors. However, recent studies have shown that ICL predominantly relies on retrieving task priors rather than "learning" to perform tasks. This limitation is particularly evident in complex subjective domains such as emotion and morality, where priors significantly influence posterior predictions. In this work, we examine whether this is the result of the aggregation used in corresponding datasets, where trying to combine low-agreement, disparate annotations might lead to annotation artifacts that create detrimental noise in the prompt. Moreover, we evaluate the posterior bias towards certain annotators by grounding our study in appropriate, quantitative measures of LLM priors. Our results indicate that aggregation is a confounding factor in the modeling of subjective tasks, and advocate focusing on modeling individuals instead. However, aggregation does not explain the entire gap between ICL and the state of the art, meaning other factors in such tasks also account for the observed phenomena. Finally, by rigorously studying annotator-level labels, we find that it is possible for minority annotators to both better align with LLMs and have their perspectives further amplified.

## Installation

This repo uses `Python 3.10` (type hints, for example, won't work with some previous versions). After you create and activate your virtual environment (with conda, venv, etc), install local dependencies with:

```bash
pip install -e .[dev]
```

## Data preparation

For CoT, we have included our annotations in `./files`. If you want to generate your own results, you can use `./scripts/cot-csv-creation.sh` to generate a CSV file with the text, add a column `cot`, and include your reasonings there.

To run the GoEmotions experiments, we recommend using the emotion pooling we set up based on the hierarchical clustering (besides, the bash scripts are set up for it). To do so, create the file `emotion_clustering.json` under the root folder of the dataset with the following contents:

```JSON
{
    "joy": [
        "amusement",
        "excitement",
        "joy",
        "love"
    ],
    "optimism": [
        "desire",
        "optimism",
        "caring"
    ],
    "admiration": [
        "pride",
        "admiration",
        "gratitude",
        "relief",
        "approval",
        "realization"
    ],
    "surprise": [
        "surprise",
        "confusion",
        "curiosity"
    ],
    "fear": [
        "fear",
        "nervousness"
    ],
    "sadness": [
        "remorse",
        "embarrassment",
        "disappointment",
        "sadness",
        "grief"
    ],
    "anger": [
        "anger",
        "disgust",
        "annoyance",
        "disapproval"
    ]
}
```

For MFRC, please create a folder for the dataset (even though we use HuggingFace `datasets` for it), and copy the file `./files/splits.yaml` to that directory.

## Run experiments

Experiments are logged with [legm](https://github.com/gchochla/legm), so refer to the documentation there for an interpretation of the resulting `logs` folder, but navigating should be intuitive enough with some trial and error. Note that some bash scripts have arguments, which are self-explanatory. Make sure to run scripts from the root directory of this repo.

Also, you should create a `.env` file with your OpenAI key if you want to perform experiments with the GPTs.

```bash
OPENAI_API_KEY=<your-openai-key>
```

Then, proceed to run the experiments in `./scripts`, sequentially and from the root of the project:
- `pipeline-<dataset-name>.sh`: scripts to run all experiments for each dataset. Arguments are parent directory of datasets (`-d`) and the location of the cache of the LLMs (`-c`; remove command line argument from script if not used)
- `plot-mfrc-authority-{., cot}.sh`: authority and purity results.
- `plot-figures-<dataset>-{., cot}.sh`: generate CSVs for plots.
- `plot-improvements.sh`: plot using previously generated CSV.

An extra file is:
- `annotator_hunting.py`: the script we used to find annotator triplets and pairs.

All other files are used within the bash scripts.