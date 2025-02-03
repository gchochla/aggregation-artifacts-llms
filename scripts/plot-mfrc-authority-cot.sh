#!/bin/bash

for label in authority equality; do
    echo "Plotting annotators GPT 3.5 single"
    python scripts/annotator-pull/compare_annotator_distributions.py \
        MFRC --root-dir /data/chochlak/mfrc --splits dev --annotation-mode aggregate \
        --annotator-experiment logs/MFRCOpenAI/gpt-3.5-turbo-cot-annotator-False-None-15-shot_0 \
        --aggr-experiment logs/MFRCOpenAI/gpt-3.5-turbo-cot-annotator-True-None-15-shot_0 \
        --prior-experiment logs/MFRCOpenAI/gpt-3.5-turbo-cot-True-annotator-True-distribution-15-shot_0/ \
        --o logs/analysis/annotators/mfrc/annotators-gpt-3.5-cot-label-$label/ \
        --alternative ann aggr prior --label $label

    echo "Plotting annotators GPT 4o mini"
    python scripts/annotator-pull/compare_annotator_distributions.py \
        MFRC --root-dir /data/chochlak/mfrc --splits dev --annotation-mode aggregate \
        --annotator-experiment logs/MFRCOpenAI/gpt-4o-mini-2024-07-18-cot-annotator-False-None-15-shot_0 \
        --aggr-experiment logs/MFRCOpenAI/gpt-4o-mini-2024-07-18-cot-annotator-True-None-15-shot_0 \
        --prior-experiment logs/MFRCOpenAI/gpt-4o-mini-2024-07-18-cot-True-annotator-True-distribution-15-shot_0/ \
        --o logs/analysis/annotators/mfrc/annotators-gpt-4o-cot-label-$label/ \
        --alternative ann aggr prior --label $label

    echo "Plotting annotators Llama 3 8b"
    python scripts/annotator-pull/compare_annotator_distributions.py \
        MFRC --root-dir /data/chochlak/mfrc --splits dev --annotation-mode aggregate \
        --annotator-experiment logs/MFRC/meta-llama--Meta-Llama-3-8B-Instruct-cot-annotator-False-None-15-shot_0 \
        --aggr-experiment logs/MFRC/meta-llama--Meta-Llama-3-8B-Instruct-cot-annotator-True-None-15-shot_0 \
        --prior-experiment logs/MFRC/meta-llama--Meta-Llama-3-8B-Instruct-cot-True-annotator-True-distribution-15-shot_0 \
        --o logs/analysis/annotators/mfrc/annotators-llama-3-8b-cot-label-$label/ \
        --alternative ann aggr prior --label $label

    echo "Plotting annotators Llama 2 7b"
    python scripts/annotator-pull/compare_annotator_distributions.py \
        MFRC --root-dir /data/chochlak/mfrc --splits dev --annotation-mode aggregate \
        --annotator-experiment logs/MFRC/meta-llama--Llama-2-7b-chat-hf-cot-annotator-False-None-15-shot_0 \
        --aggr-experiment logs/MFRC/meta-llama--Llama-2-7b-chat-hf-cot-annotator-True-None-15-shot_0 \
        --prior-experiment logs/MFRC/meta-llama--Llama-2-7b-chat-hf-cot-True-annotator-True-distribution-15-shot_0 \
        --o logs/analysis/annotators/mfrc/annotators-llama-2-7b-cot-label-$label/ \
        --alternative ann aggr prior --label $label

    echo "Plotting annotators Llama 3 70b"
    python scripts/annotator-pull/compare_annotator_distributions.py \
        MFRC --root-dir /data/chochlak/mfrc --splits dev --annotation-mode aggregate \
        --annotator-experiment logs/MFRC/meta-llama--Meta-Llama-3-70B-Instruct-cot-annotator-False-None-15-shot_0 \
        --aggr-experiment logs/MFRC/meta-llama--Meta-Llama-3-70B-Instruct-cot-annotator-True-None-15-shot_0 \
        --prior-experiment logs/MFRC/meta-llama--Meta-Llama-3-70B-Instruct-cot-True-annotator-True-distribution-15-shot_0 \
        --o logs/analysis/annotators/mfrc/annotators-llama-3-70b-cot-label-$label/ \
        --alternative ann aggr prior --label $label

    echo "Plotting annotators Llama 2 70b"
    python scripts/annotator-pull/compare_annotator_distributions.py \
        MFRC --root-dir /data/chochlak/mfrc --splits dev --annotation-mode aggregate \
        --annotator-experiment logs/MFRC/meta-llama--Llama-2-70b-chat-hf-cot-annotator-False-None-15-shot_0 \
        --aggr-experiment logs/MFRC/meta-llama--Llama-2-70b-chat-hf-cot-annotator-True-None-15-shot_0 \
        --prior-experiment logs/MFRC/meta-llama--Llama-2-70b-chat-hf-cot-True-annotator-True-distribution-15-shot_0 \
        --o logs/analysis/annotators/mfrc/annotators-llama-2-70b-cot-label-$label \
        --alternative ann aggr prior --label $label

    # calculate similarities and improvements

    python scripts/annotator-pull/calculate_annotator_improvement.py \
        --annotator-results-dir logs/analysis/annotators/mfrc/annotators-gpt-3.5-cot-label-$label/ \
        --output-dir logs/analysis/annotators/mfrc/annotators-gpt-3.5-cot-improvement-label-$label/ --metric "${label}_f1"

    python scripts/annotator-pull/calculate_annotator_improvement.py \
        --annotator-results-dir logs/analysis/annotators/mfrc/annotators-gpt-4o-cot-label-$label/ \
        --output-dir logs/analysis/annotators/mfrc/annotators-gpt-4o-cot-improvement-label-$label/ --metric "${label}_f1"

    python scripts/annotator-pull/calculate_annotator_improvement.py \
        --annotator-results-dir logs/analysis/annotators/mfrc/annotators-llama-3-8b-cot-label-$label/ \
        --output-dir logs/analysis/annotators/mfrc/annotators-llama-3-8b-cot-improvement-label-$label/ --metric "${label}_f1"

    python scripts/annotator-pull/calculate_annotator_improvement.py \
        --annotator-results-dir logs/analysis/annotators/mfrc/annotators-llama-2-7b-cot-label-$label/ \
        --output-dir logs/analysis/annotators/mfrc/annotators-llama-2-7b-cot-improvement-label-$label/ --metric "${label}_f1"

    python scripts/annotator-pull/calculate_annotator_improvement.py \
        --annotator-results-dir logs/analysis/annotators/mfrc/annotators-llama-3-70b-cot-label-$label/  \
        --output-dir logs/analysis/annotators/mfrc/annotators-llama-3-70b-cot-improvement-label-$label/ --metric "${label}_f1"

    python scripts/annotator-pull/calculate_annotator_improvement.py \
        --annotator-results-dir logs/analysis/annotators/mfrc/annotators-llama-2-70b-cot-label-$label/ \
        --output-dir logs/analysis/annotators/mfrc/annotators-llama-2-70b-cot-improvement-label-$label/ --metric "${label}_f1"

done