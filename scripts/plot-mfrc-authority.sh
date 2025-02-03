#!/bin/bash


for label in authority equality; do
    # annotators GPT 3.5
    echo "Plotting annotators GPT 3.5 single"
    python scripts/annotator-pull/compare_annotator_distributions.py \
        MFRC --root-dir /data/chochlak/mfrc --splits dev --annotation-mode aggregate \
        --annotator-experiment logs/MFRCOpenAI/gpt-3.5-turbo-annotator-False-None-45-shot_0 \
        --aggr-experiment logs/MFRCOpenAI/gpt-3.5-turbo-annotator-True-None-45-shot_0 \
        --prior-experiment logs/MFRCOpenAI/gpt-3.5-turbo-annotator-True-distribution-45-shot_0/ \
        --o logs/analysis/annotators/mfrc/annotators-gpt-3.5-label-$label/ \
        --alternative ann aggr prior --label $label

    # annotators GPT 4o mini
    echo "Plotting annotators GPT 4o mini single"
    python scripts/annotator-pull/compare_annotator_distributions.py \
        MFRC --root-dir /data/chochlak/mfrc --splits dev --annotation-mode aggregate \
        --annotator-experiment logs/MFRCOpenAI/gpt-4o-mini-2024-07-18-annotator-False-None-45-shot_0 \
        --aggr-experiment logs/MFRCOpenAI/gpt-4o-mini-2024-07-18-annotator-True-None-45-shot_0 \
        --prior-experiment logs/MFRCOpenAI/gpt-4o-mini-2024-07-18-annotator-True-distribution-45-shot_0/ \
        --o logs/analysis/annotators/mfrc/annotators-gpt-4o-label-$label/ \
        --alternative ann aggr prior --label $label

    echo "Plotting annotators Llama 3 8b single"
    python scripts/annotator-pull/compare_annotator_distributions.py \
        MFRC --root-dir /data/chochlak/mfrc --splits dev --annotation-mode aggregate \
        --annotator-experiment logs/MFRC/meta-llama--Meta-Llama-3-8B-Instruct-annotator-False-None-45-shot_0 \
        --aggr-experiment logs/MFRC/meta-llama--Meta-Llama-3-8B-Instruct-annotator-True-None-45-shot_0 \
        --prior-experiment logs/MFRC/meta-llama--Meta-Llama-3-8B-Instruct-annotator-True-distribution-25-shot_0 \
        --o logs/analysis/annotators/mfrc/annotators-llama-3-8b-label-$label/ \
        --alternative ann aggr prior --label $label

    echo "Plotting annotators Llama 2 7b single"
    python scripts/annotator-pull/compare_annotator_distributions.py \
        MFRC --root-dir /data/chochlak/mfrc --splits dev --annotation-mode aggregate \
        --annotator-experiment logs/MFRC/meta-llama--Llama-2-7b-chat-hf-annotator-False-None-45-shot_0 \
        --aggr-experiment logs/MFRC/meta-llama--Llama-2-7b-chat-hf-annotator-True-None-45-shot_0 \
        --prior-experiment logs/MFRC/meta-llama--Llama-2-7b-chat-hf-annotator-True-distribution-25-shot_0 \
        --o logs/analysis/annotators/mfrc/annotators-llama-2-7b-label-$label/ \
        --alternative ann aggr prior --label $label

    echo "Plotting annotators Llama 3 70b single"
    python scripts/annotator-pull/compare_annotator_distributions.py \
        MFRC --root-dir /data/chochlak/mfrc --splits dev --annotation-mode aggregate \
        --annotator-experiment logs/MFRC/meta-llama--Meta-Llama-3-70B-Instruct-annotator-False-None-45-shot_0 \
        --aggr-experiment logs/MFRC/meta-llama--Meta-Llama-3-70B-Instruct-annotator-True-None-45-shot_0 \
        --prior-experiment logs/MFRC/meta-llama--Meta-Llama-3-70B-Instruct-annotator-True-distribution-25-shot_0 \
        --o logs/analysis/annotators/mfrc/annotators-llama-3-70b-label-$label/ \
        --alternative ann aggr prior --label $label

    echo "Plotting annotators Llama 2 70b single"
    python scripts/annotator-pull/compare_annotator_distributions.py \
        MFRC --root-dir /data/chochlak/mfrc --splits dev --annotation-mode aggregate \
        --annotator-experiment logs/MFRC/meta-llama--Llama-2-70b-chat-hf-annotator-False-None-45-shot_0 \
        --aggr-experiment logs/MFRC/meta-llama--Llama-2-70b-chat-hf-annotator-True-None-45-shot_0 \
        --prior-experiment logs/MFRC/meta-llama--Llama-2-70b-chat-hf-annotator-True-distribution-25-shot_0 \
        --o logs/analysis/annotators/mfrc/annotators-llama-2-70b-label-$label/ \
        --alternative ann aggr prior --label $label

    # calculate similarities and improvements

    python scripts/annotator-pull/calculate_annotator_improvement.py \
        --annotator-results-dir logs/analysis/annotators/mfrc/annotators-gpt-3.5-label-$label/ \
        --output-dir logs/analysis/annotators/mfrc/annotators-gpt-3.5-improvement-label-$label/ --metric "${label}_f1"

    python scripts/annotator-pull/calculate_annotator_improvement.py \
        --annotator-results-dir logs/analysis/annotators/mfrc/annotators-gpt-4o-label-$label/ \
        --output-dir logs/analysis/annotators/mfrc/annotators-label-gpt-4o-improvement-label-$label/ --metric "${label}_f1"

    python scripts/annotator-pull/calculate_annotator_improvement.py \
        --annotator-results-dir logs/analysis/annotators/mfrc/annotators-llama-3-8b-label-$label/ \
        --output-dir logs/analysis/annotators/mfrc/annotators-label-llama-3-8b-improvement-label-$label/ --metric "${label}_f1"

    python scripts/annotator-pull/calculate_annotator_improvement.py \
        --annotator-results-dir logs/analysis/annotators/mfrc/annotators-llama-2-7b-label-$label/ \
        --output-dir logs/analysis/annotators/mfrc/annotators-label-llama-2-7b-improvement-label-$label/ --metric "${label}_f1"

    python scripts/annotator-pull/calculate_annotator_improvement.py \
        --annotator-results-dir logs/analysis/annotators/mfrc/annotators-llama-3-70b-label-$label/ \
        --output-dir logs/analysis/annotators/mfrc/annotators-label-llama-3-70b-improvement-label-$label/ --metric "${label}_f1"

    python scripts/annotator-pull/calculate_annotator_improvement.py \
        --annotator-results-dir logs/analysis/annotators/mfrc/annotators-llama-2-70b-label-$label/ \
        --output-dir logs/analysis/annotators/mfrc/annotators-label-llama-2-70b-improvement-label-$label/ --metric "${label}_f1"
done