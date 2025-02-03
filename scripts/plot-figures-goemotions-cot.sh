#!/bin/bash

echo "Plotting annotators GPT 3.5 single"
python scripts/annotator-pull/compare_annotator_distributions.py \
    GoEmotions --root-dir /data/chochlak/goemotions --splits dev --annotation-mode aggregate \
    --emotion-clustering-json /data/chochlak/goemotions/emotion_clustering.json \
    --annotator-experiment logs/GoEmotionsOpenAI/gpt-3.5-turbo-cot-annotator-False-None-15-shot_0 \
    --aggr-experiment logs/GoEmotionsOpenAI/gpt-3.5-turbo-cot-annotator-True-None-15-shot_0 \
    --prior-experiment logs/GoEmotionsOpenAI/gpt-3.5-turbo-cot-True-annotator-True-distribution-15-shot_0/ \
    --o logs/analysis/annotators/goemotions/annotators-gpt-3.5-cot/ \
    --alternative ann aggr prior

echo "Plotting annotators GPT 4o mini"
python scripts/annotator-pull/compare_annotator_distributions.py \
    GoEmotions --root-dir /data/chochlak/goemotions --splits dev --annotation-mode aggregate \
    --emotion-clustering-json /data/chochlak/goemotions/emotion_clustering.json \
    --annotator-experiment logs/GoEmotionsOpenAI/gpt-4o-mini-2024-07-18-cot-annotator-False-None-15-shot_0 \
    --aggr-experiment logs/GoEmotionsOpenAI/gpt-4o-mini-2024-07-18-cot-annotator-True-None-15-shot_0 \
    --prior-experiment logs/GoEmotionsOpenAI/gpt-4o-mini-2024-07-18-cot-True-annotator-True-distribution-15-shot_0/ \
    --o logs/analysis/annotators/goemotions/annotators-gpt-4o-cot/ \
    --alternative ann aggr prior

echo "Plotting annotators Llama 3 8b"
python scripts/annotator-pull/compare_annotator_distributions.py \
    GoEmotions --root-dir /data/chochlak/goemotions --splits dev --annotation-mode aggregate \
    --emotion-clustering-json /data/chochlak/goemotions/emotion_clustering.json \
    --annotator-experiment logs/GoEmotions/meta-llama--Meta-Llama-3-8B-Instruct-cot-annotator-False-None-15-shot_0 \
    --aggr-experiment logs/GoEmotions/meta-llama--Meta-Llama-3-8B-Instruct-cot-annotator-True-None-15-shot_0 \
    --prior-experiment logs/GoEmotions/meta-llama--Meta-Llama-3-8B-Instruct-cot-True-annotator-True-distribution-15-shot_0 \
    --o logs/analysis/annotators/goemotions/annotators-llama-3-8b-cot/ \
    --alternative ann aggr prior

echo "Plotting annotators Llama 2 7b"
python scripts/annotator-pull/compare_annotator_distributions.py \
    GoEmotions --root-dir /data/chochlak/goemotions --splits dev --annotation-mode aggregate \
    --emotion-clustering-json /data/chochlak/goemotions/emotion_clustering.json \
    --annotator-experiment logs/GoEmotions/meta-llama--Llama-2-7b-chat-hf-cot-annotator-False-None-15-shot_0 \
    --aggr-experiment logs/GoEmotions/meta-llama--Llama-2-7b-chat-hf-cot-annotator-True-None-15-shot_0 \
    --prior-experiment logs/GoEmotions/meta-llama--Llama-2-7b-chat-hf-cot-True-annotator-True-distribution-15-shot_0 \
    --o logs/analysis/annotators/goemotions/annotators-llama-2-7b-cot/ \
    --alternative ann aggr prior

echo "Plotting annotators Llama 3 70b"
python scripts/annotator-pull/compare_annotator_distributions.py \
    GoEmotions --root-dir /data/chochlak/goemotions --splits dev --annotation-mode aggregate \
    --emotion-clustering-json /data/chochlak/goemotions/emotion_clustering.json \
    --annotator-experiment logs/GoEmotions/meta-llama--Meta-Llama-3-70B-Instruct-cot-annotator-False-None-15-shot_0 \
    --aggr-experiment logs/GoEmotions/meta-llama--Meta-Llama-3-70B-Instruct-cot-annotator-True-None-15-shot_0 \
    --prior-experiment logs/GoEmotions/meta-llama--Meta-Llama-3-70B-Instruct-cot-True-annotator-True-distribution-15-shot_0 \
    --o logs/analysis/annotators/goemotions/annotators-llama-3-70b-cot/ \
    --alternative ann aggr prior

echo "Plotting annotators Llama 2 70b"
python scripts/annotator-pull/compare_annotator_distributions.py \
    GoEmotions --root-dir /data/chochlak/goemotions --splits dev --annotation-mode aggregate \
    --emotion-clustering-json /data/chochlak/goemotions/emotion_clustering.json \
    --annotator-experiment logs/GoEmotions/meta-llama--Llama-2-70b-chat-hf-cot-annotator-False-None-15-shot_0 \
    --aggr-experiment logs/GoEmotions/meta-llama--Llama-2-70b-chat-hf-cot-annotator-True-None-15-shot_0 \
    --prior-experiment logs/GoEmotions/meta-llama--Llama-2-70b-chat-hf-cot-True-annotator-True-distribution-15-shot_0 \
    --o logs/analysis/annotators/goemotions/annotators-llama-2-70b-cot/ \
    --alternative ann aggr prior

# calculate similarities and improvements

python scripts/annotator-pull/calculate_annotator_improvement.py \
    --annotator-results-dir logs/analysis/annotators/goemotions/annotators-gpt-3.5-cot/ \
    --output-dir logs/analysis/annotators/goemotions/annotators-gpt-3.5-cot-improvement/

python scripts/annotator-pull/calculate_annotator_improvement.py \
    --annotator-results-dir logs/analysis/annotators/goemotions/annotators-gpt-4o-cot/ \
    --output-dir logs/analysis/annotators/goemotions/annotators-gpt-4o-cot-improvement/

python scripts/annotator-pull/calculate_annotator_improvement.py \
    --annotator-results-dir logs/analysis/annotators/goemotions/annotators-llama-3-8b-cot/ \
    --output-dir logs/analysis/annotators/goemotions/annotators-llama-3-8b-cot-improvement/

python scripts/annotator-pull/calculate_annotator_improvement.py \
    --annotator-results-dir logs/analysis/annotators/goemotions/annotators-llama-2-7b-cot/ \
    --output-dir logs/analysis/annotators/goemotions/annotators-llama-2-7b-cot-improvement/

python scripts/annotator-pull/calculate_annotator_improvement.py \
    --annotator-results-dir logs/analysis/annotators/goemotions/annotators-llama-3-70b-cot/  \
    --output-dir logs/analysis/annotators/goemotions/annotators-llama-3-70b-cot-improvement/

python scripts/annotator-pull/calculate_annotator_improvement.py \
    --annotator-results-dir logs/analysis/annotators/goemotions/annotators-llama-2-70b-cot/ \
    --output-dir logs/analysis/annotators/goemotions/annotators-llama-2-70b-cot-improvement/

# plot improvements

python scripts/annotator-pull/plot_improvements.py \
    --i logs/analysis/annotators/mfrc/annotators-llama-3-8b-cot-improvement \
    logs/analysis/annotators/mfrc/annotators-llama-2-7b-cot-improvement \
    logs/analysis/annotators/mfrc/annotators-llama-3-70b-cot-improvement \
    logs/analysis/annotators/mfrc/annotators-llama-2-70b-cot-improvement \
    logs/analysis/annotators/mfrc/annotators-gpt-3.5-cot-improvement \
    logs/analysis/annotators/mfrc/annotators-gpt-4o-cot-improvement \
    logs/analysis/annotators/goemotions/annotators-llama-3-8b-cot-improvement \
    logs/analysis/annotators/goemotions/annotators-llama-2-7b-cot-improvement \
    logs/analysis/annotators/goemotions/annotators-llama-3-70b-cot-improvement \
    logs/analysis/annotators/goemotions/annotators-llama-2-70b-cot-improvement \
    logs/analysis/annotators/goemotions/annotators-gpt-3.5-cot-improvement \
    logs/analysis/annotators/goemotions/annotators-gpt-4o-cot-improvement \
    --name Llama-2-7b-chat-hf Meta-Llama-3-8b-Instruct Llama-2-70b-chat-hf Meta-Llama-3-70b-Instruct gpt-3.5-turbo gpt-4o-mini \
    --row-name MFRC GoEmotions --row-metric micro_f1 jaccard_score \
    --o logs/analysis/annotators/cot-results --type prior-aggr