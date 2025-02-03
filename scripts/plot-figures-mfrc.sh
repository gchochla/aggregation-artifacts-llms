#!/bin/bash

# annotators GPT 3.5
echo "Plotting annotators GPT 3.5 single"
python scripts/annotator-pull/compare_annotator_distributions.py \
    MFRC --root-dir /data/chochlak/mfrc --splits dev --annotation-mode aggregate \
    --annotator-experiment logs/MFRCOpenAI/gpt-3.5-turbo-annotator-False-None-45-shot_0 \
    --aggr-experiment logs/MFRCOpenAI/gpt-3.5-turbo-annotator-True-None-45-shot_0 \
    --prior-experiment logs/MFRCOpenAI/gpt-3.5-turbo-annotator-True-distribution-45-shot_0/ \
    --o logs/analysis/annotators/mfrc/annotators-gpt-3.5-single/ \
    --alternative ann aggr prior

echo "Plotting annotators GPT 3.5 single 2"
python scripts/annotator-pull/compare_annotator_distributions.py \
    MFRC --root-dir /data/chochlak/mfrc --splits dev --annotation-mode aggregate \
    --annotator-experiment logs/MFRCOpenAI/gpt-3.5-turbo-annotator-False-None-45-shot_1 \
    --aggr-experiment logs/MFRCOpenAI/gpt-3.5-turbo-annotator-True-None-45-shot_1 \
    --prior-experiment logs/MFRCOpenAI/gpt-3.5-turbo-annotator-True-distribution-45-shot_1 \
    --o logs/analysis/annotators/mfrc/annotators-gpt-3.5-single-2/ \
    --alternative ann aggr prior

# annotators GPT 4o mini
echo "Plotting annotators GPT 4o mini single"
python scripts/annotator-pull/compare_annotator_distributions.py \
    MFRC --root-dir /data/chochlak/mfrc --splits dev --annotation-mode aggregate \
    --annotator-experiment logs/MFRCOpenAI/gpt-4o-mini-2024-07-18-annotator-False-None-45-shot_0 \
    --aggr-experiment logs/MFRCOpenAI/gpt-4o-mini-2024-07-18-annotator-True-None-45-shot_0 \
    --prior-experiment logs/MFRCOpenAI/gpt-4o-mini-2024-07-18-annotator-True-distribution-45-shot_0/ \
    --o logs/analysis/annotators/mfrc/annotators-gpt-4o-single/ \
    --alternative ann aggr prior

echo "Plotting annotators GPT 4o mini single 2"
python scripts/annotator-pull/compare_annotator_distributions.py \
    MFRC --root-dir /data/chochlak/mfrc --splits dev --annotation-mode aggregate \
    --annotator-experiment logs/MFRCOpenAI/gpt-4o-mini-2024-07-18-annotator-False-None-45-shot_1 \
    --aggr-experiment logs/MFRCOpenAI/gpt-4o-mini-2024-07-18-annotator-True-None-45-shot_1 \
    --prior-experiment logs/MFRCOpenAI/gpt-4o-mini-2024-07-18-annotator-True-distribution-45-shot_1 \
    --o logs/analysis/annotators/mfrc/annotators-gpt-4o-single-2/ \
    --alternative ann aggr prior

# # annotators Llama 3 8b
# echo "Plotting annotators Llama 3 8b"
# python scripts/annotator-pull/compare_annotator_distributions.py \
#     MFRC --root-dir /data/chochlak/mfrc --splits dev --annotation-mode aggregate \
#     --annotator-experiment logs/MFRC/meta-llama--Meta-Llama-3-8B-Instruct-annotator-False-None-5-shot_0 \
#     logs/MFRC/meta-llama--Meta-Llama-3-8B-Instruct-annotator-False-None-15-shot_0 \
#     logs/MFRC/meta-llama--Meta-Llama-3-8B-Instruct-annotator-False-None-25-shot_0 \
#     logs/MFRC/meta-llama--Meta-Llama-3-8B-Instruct-annotator-False-None-45-shot_0 \
#     --aggr-experiment logs/MFRC/meta-llama--Meta-Llama-3-8B-Instruct-annotator-True-None-45-shot_0 \
#     --prior-experiment logs/MFRC/meta-llama--Meta-Llama-3-8B-Instruct-annotator-True-distribution-5-shot_0 \
#     logs/MFRC/meta-llama--Meta-Llama-3-8B-Instruct-annotator-True-distribution-15-shot_0 \
#     logs/MFRC/meta-llama--Meta-Llama-3-8B-Instruct-annotator-True-distribution-25-shot_0 \
#     logs/MFRC/meta-llama--Meta-Llama-3-8B-Instruct-annotator-True-distribution-45-shot_0 \
#     --o logs/analysis/annotators/mfrc/annotators-llama-3-8b/ \
#     --alternative 5s 15s 25s 45s aggr-45s prior-5s prior-15s prior-25s prior-45s

echo "Plotting annotators Llama 3 8b single"
python scripts/annotator-pull/compare_annotator_distributions.py \
    MFRC --root-dir /data/chochlak/mfrc --splits dev --annotation-mode aggregate \
    --annotator-experiment logs/MFRC/meta-llama--Meta-Llama-3-8B-Instruct-annotator-False-None-45-shot_0 \
    --aggr-experiment logs/MFRC/meta-llama--Meta-Llama-3-8B-Instruct-annotator-True-None-45-shot_0 \
    --prior-experiment logs/MFRC/meta-llama--Meta-Llama-3-8B-Instruct-annotator-True-distribution-25-shot_0 \
    --o logs/analysis/annotators/mfrc/annotators-llama-3-8b-single/ \
    --alternative ann aggr prior

echo "Plotting annotators Llama 3 8b single 2"
python scripts/annotator-pull/compare_annotator_distributions.py \
    MFRC --root-dir /data/chochlak/mfrc --splits dev --annotation-mode aggregate \
    --annotator-experiment logs/MFRC/meta-llama--Meta-Llama-3-8B-Instruct-annotator-False-None-45-shot_1 \
    --aggr-experiment logs/MFRC/meta-llama--Meta-Llama-3-8B-Instruct-annotator-True-None-45-shot_1 \
    --prior-experiment logs/MFRC/meta-llama--Meta-Llama-3-8B-Instruct-annotator-True-distribution-25-shot_1 \
    --o logs/analysis/annotators/mfrc/annotators-llama-3-8b-single-2/ \
    --alternative ann aggr prior

# # annotators Llama 2 7b
# echo "Plotting annotators Llama 2 7b"
# python scripts/annotator-pull/compare_annotator_distributions.py \
#     MFRC --root-dir /data/chochlak/mfrc --splits dev --annotation-mode aggregate \
#     --annotator-experiment logs/MFRC/meta-llama--Llama-2-7b-chat-hf-annotator-False-None-5-shot_0 \
#     logs/MFRC/meta-llama--Llama-2-7b-chat-hf-annotator-False-None-15-shot_0 \
#     logs/MFRC/meta-llama--Llama-2-7b-chat-hf-annotator-False-None-25-shot_0 \
#     logs/MFRC/meta-llama--Llama-2-7b-chat-hf-annotator-False-None-45-shot_0 \
#     --aggr-experiment logs/MFRC/meta-llama--Llama-2-7b-chat-hf-annotator-True-None-45-shot_0 \
#     --prior-experiment logs/MFRC/meta-llama--Llama-2-7b-chat-hf-annotator-True-distribution-5-shot_0 \
#     logs/MFRC/meta-llama--Llama-2-7b-chat-hf-annotator-True-distribution-15-shot_0 \
#     logs/MFRC/meta-llama--Llama-2-7b-chat-hf-annotator-True-distribution-25-shot_0 \
#     logs/MFRC/meta-llama--Llama-2-7b-chat-hf-annotator-True-distribution-45-shot_0 \
#     --o logs/analysis/annotators/mfrc/annotators-llama-2-7b/ \
#     --alternative 5s 15s 25s 45s aggr-45s prior-5s prior-15s prior-25s prior-45s

echo "Plotting annotators Llama 2 7b single"
python scripts/annotator-pull/compare_annotator_distributions.py \
    MFRC --root-dir /data/chochlak/mfrc --splits dev --annotation-mode aggregate \
    --annotator-experiment logs/MFRC/meta-llama--Llama-2-7b-chat-hf-annotator-False-None-45-shot_0 \
    --aggr-experiment logs/MFRC/meta-llama--Llama-2-7b-chat-hf-annotator-True-None-45-shot_0 \
    --prior-experiment logs/MFRC/meta-llama--Llama-2-7b-chat-hf-annotator-True-distribution-25-shot_0 \
    --o logs/analysis/annotators/mfrc/annotators-llama-2-7b-single/ \
    --alternative ann aggr prior

echo "Plotting annotators Llama 2 7b single 2"
python scripts/annotator-pull/compare_annotator_distributions.py \
    MFRC --root-dir /data/chochlak/mfrc --splits dev --annotation-mode aggregate \
    --annotator-experiment logs/MFRC/meta-llama--Llama-2-7b-chat-hf-annotator-False-None-45-shot_1 \
    --aggr-experiment logs/MFRC/meta-llama--Llama-2-7b-chat-hf-annotator-True-None-45-shot_1 \
    --prior-experiment logs/MFRC/meta-llama--Llama-2-7b-chat-hf-annotator-True-distribution-25-shot_1 \
    --o logs/analysis/annotators/mfrc/annotators-llama-2-7b-single-2/ \
    --alternative ann aggr prior

# # annotators Llama 3 70b
# echo "Plotting annotators Llama 3 70b"
# python scripts/annotator-pull/compare_annotator_distributions.py \
#     MFRC --root-dir /data/chochlak/mfrc --splits dev --annotation-mode aggregate \
#     --annotator-experiment logs/MFRC/meta-llama--Meta-Llama-3-70B-Instruct-annotator-False-None-5-shot_0 \
#     logs/MFRC/meta-llama--Meta-Llama-3-70B-Instruct-annotator-False-None-25-shot_0 \
#     logs/MFRC/meta-llama--Meta-Llama-3-70B-Instruct-annotator-False-None-45-shot_0 \
#     --aggr-experiment logs/MFRC/meta-llama--Meta-Llama-3-70B-Instruct-annotator-True-None-45-shot_0 \
#     --prior-experiment logs/MFRC/meta-llama--Meta-Llama-3-70B-Instruct-annotator-True-distribution-5-shot_0 \
#     logs/MFRC/meta-llama--Meta-Llama-3-70B-Instruct-annotator-True-distribution-25-shot_0 \
#     logs/MFRC/meta-llama--Meta-Llama-3-70B-Instruct-annotator-True-distribution-45-shot_0 \
#     --o logs/analysis/annotators/mfrc/annotators-llama-3-70b/ \
#     --alternative 5s 25s 45s aggr-45s prior-5s prior-25s prior-45s

echo "Plotting annotators Llama 3 70b single"
python scripts/annotator-pull/compare_annotator_distributions.py \
    MFRC --root-dir /data/chochlak/mfrc --splits dev --annotation-mode aggregate \
    --annotator-experiment logs/MFRC/meta-llama--Meta-Llama-3-70B-Instruct-annotator-False-None-45-shot_0 \
    --aggr-experiment logs/MFRC/meta-llama--Meta-Llama-3-70B-Instruct-annotator-True-None-45-shot_0 \
    --prior-experiment logs/MFRC/meta-llama--Meta-Llama-3-70B-Instruct-annotator-True-distribution-25-shot_0 \
    --o logs/analysis/annotators/mfrc/annotators-llama-3-70b-single/ \
    --alternative ann aggr prior

echo "Plotting annotators Llama 3 70b single 2"
python scripts/annotator-pull/compare_annotator_distributions.py \
    MFRC --root-dir /data/chochlak/mfrc --splits dev --annotation-mode aggregate \
    --annotator-experiment logs/MFRC/meta-llama--Meta-Llama-3-70B-Instruct-annotator-False-None-45-shot_1 \
    --aggr-experiment logs/MFRC/meta-llama--Meta-Llama-3-70B-Instruct-annotator-True-None-45-shot_1 \
    --prior-experiment logs/MFRC/meta-llama--Meta-Llama-3-70B-Instruct-annotator-True-distribution-25-shot_1 \
    --o logs/analysis/annotators/mfrc/annotators-llama-3-70b-single-2/ \
    --alternative ann aggr prior

# # annotators Llama 2 70b
# echo "Plotting annotators Llama 2 70b"
# python scripts/annotator-pull/compare_annotator_distributions.py \
#     MFRC --root-dir /data/chochlak/mfrc --splits dev --annotation-mode aggregate \
#     --annotator-experiment logs/MFRC/meta-llama--Llama-2-70b-chat-hf-annotator-False-None-5-shot_0 \
#     logs/MFRC/meta-llama--Llama-2-70b-chat-hf-annotator-False-None-25-shot_0 \
#     logs/MFRC/meta-llama--Llama-2-70b-chat-hf-annotator-False-None-45-shot_0 \
#     --aggr-experiment logs/MFRC/meta-llama--Llama-2-70b-chat-hf-annotator-True-None-45-shot_0 \
#     --prior-experiment logs/MFRC/meta-llama--Llama-2-70b-chat-hf-annotator-True-distribution-5-shot_0 \
#     logs/MFRC/meta-llama--Llama-2-70b-chat-hf-annotator-True-distribution-25-shot_0 \
#     logs/MFRC/meta-llama--Llama-2-70b-chat-hf-annotator-True-distribution-45-shot_0 \
#     --o logs/analysis/annotators/mfrc/annotators-llama-2-70b/ \
#     --alternative 5s 25s 45s aggr-45s prior-5s prior-25s prior-45s

echo "Plotting annotators Llama 2 70b single"
python scripts/annotator-pull/compare_annotator_distributions.py \
    MFRC --root-dir /data/chochlak/mfrc --splits dev --annotation-mode aggregate \
    --annotator-experiment logs/MFRC/meta-llama--Llama-2-70b-chat-hf-annotator-False-None-45-shot_0 \
    --aggr-experiment logs/MFRC/meta-llama--Llama-2-70b-chat-hf-annotator-True-None-45-shot_0 \
    --prior-experiment logs/MFRC/meta-llama--Llama-2-70b-chat-hf-annotator-True-distribution-25-shot_0 \
    --o logs/analysis/annotators/mfrc/annotators-llama-2-70b-single/ \
    --alternative ann aggr prior

echo "Plotting annotators Llama 2 70b single 2"
python scripts/annotator-pull/compare_annotator_distributions.py \
    MFRC --root-dir /data/chochlak/mfrc --splits dev --annotation-mode aggregate \
    --annotator-experiment logs/MFRC/meta-llama--Llama-2-70b-chat-hf-annotator-False-None-45-shot_1 \
    --aggr-experiment logs/MFRC/meta-llama--Llama-2-70b-chat-hf-annotator-True-None-45-shot_1 \
    --prior-experiment logs/MFRC/meta-llama--Llama-2-70b-chat-hf-annotator-True-distribution-25-shot_1 \
    --o logs/analysis/annotators/mfrc/annotators-llama-2-70b-single-2/ \
    --alternative ann aggr prior

# calculate similarities and improvements

python scripts/annotator-pull/calculate_annotator_improvement.py \
    --annotator-results-dir logs/analysis/annotators/mfrc/annotators-gpt-3.5-single/ logs/analysis/annotators/mfrc/annotators-gpt-3.5-single-2/ \
    --output-dir logs/analysis/annotators/mfrc/annotators-gpt-3.5-single-improvement/ --metric micro_f1

python scripts/annotator-pull/calculate_annotator_improvement.py \
    --annotator-results-dir logs/analysis/annotators/mfrc/annotators-gpt-4o-single/ logs/analysis/annotators/mfrc/annotators-gpt-4o-single-2/ \
    --output-dir logs/analysis/annotators/mfrc/annotators-gpt-4o-single-improvement/ --metric micro_f1

python scripts/annotator-pull/calculate_annotator_improvement.py \
    --annotator-results-dir logs/analysis/annotators/mfrc/annotators-llama-3-8b-single/ logs/analysis/annotators/mfrc/annotators-llama-3-8b-single-2/ \
    --output-dir logs/analysis/annotators/mfrc/annotators-llama-3-8b-single-improvement/ --metric micro_f1

python scripts/annotator-pull/calculate_annotator_improvement.py \
    --annotator-results-dir logs/analysis/annotators/mfrc/annotators-llama-2-7b-single/ logs/analysis/annotators/mfrc/annotators-llama-2-7b-single-2/ \
    --output-dir logs/analysis/annotators/mfrc/annotators-llama-2-7b-single-improvement/ --metric micro_f1

python scripts/annotator-pull/calculate_annotator_improvement.py \
    --annotator-results-dir logs/analysis/annotators/mfrc/annotators-llama-3-70b-single/ logs/analysis/annotators/mfrc/annotators-llama-3-70b-single-2/ \
    --output-dir logs/analysis/annotators/mfrc/annotators-llama-3-70b-single-improvement/ --metric micro_f1

python scripts/annotator-pull/calculate_annotator_improvement.py \
    --annotator-results-dir logs/analysis/annotators/mfrc/annotators-llama-2-70b-single/ logs/analysis/annotators/mfrc/annotators-llama-2-70b-single-2/ \
    --output-dir logs/analysis/annotators/mfrc/annotators-llama-2-70b-single-improvement/ --metric micro_f1

# plot improvements

# python scripts/annotator-pull/plot_improvements.py \
#     --i logs/analysis/annotators/mfrc/annotators-gpt-3.5-single-improvement \
#     logs/analysis/annotators/mfrc/annotators-gpt-4o-single-improvement \
#     logs/analysis/annotators/mfrc/annotators-llama-3-8b-single-improvement \
#     logs/analysis/annotators/mfrc/annotators-llama-2-7b-single-improvement \
#     logs/analysis/annotators/mfrc/annotators-llama-3-70b-single-improvement \
#     logs/analysis/annotators/mfrc/annotators-llama-2-70b-single-improvement \
#     --name GPT-3.5 GPT-4o Llama-2-7b Llama-3-8b Llama-2-70b Llama-3-70b \
#     --o logs/analysis/annotators/results

# python scripts/annotator-pull/plot_improvements.py \
#     --i logs/analysis/annotators/mfrc/annotators-gpt-3.5-single-improvement \
#     logs/analysis/annotators/mfrc/annotators-gpt-4o-single-improvement \
#     logs/analysis/annotators/mfrc/annotators-llama-3-8b-single-improvement \
#     logs/analysis/annotators/mfrc/annotators-llama-2-7b-single-improvement \
#     --name GPT-3.5 GPT-4o Llama-2-7b Llama-3-8b \
#     --o logs/analysis/annotators/results

# python scripts/annotator-pull/plot_improvements.py \
#     --i logs/analysis/annotators/mfrc/annotators-gpt-3.5-single-improvement \
#     logs/analysis/annotators/mfrc/annotators-gpt-4o-single-improvement \
#     logs/analysis/annotators/mfrc/annotators-llama-3-8b-single-improvement \
#     logs/analysis/annotators/mfrc/annotators-llama-2-7b-single-improvement \
#     logs/analysis/annotators/goemotions/annotators-gpt-3.5-single-improvement \
#     logs/analysis/annotators/goemotions/annotators-gpt-4o-single-improvement \
#     logs/analysis/annotators/goemotions/annotators-llama-3-8b-single-improvement \
#     logs/analysis/annotators/goemotions/annotators-llama-2-7b-single-improvement \
#     --name GPT-3.5 GPT-4o Llama-2-7b Llama-3-8b \
#     --row-name MFRC GoEmotions \
#     --o logs/analysis/annotators/results

python scripts/annotator-pull/plot_improvements_similarity_to_prior.py \
    --i logs/analysis/annotators/mfrc/annotators-llama-3-8b-single-improvement \
    logs/analysis/annotators/mfrc/annotators-llama-2-7b-single-improvement \
    logs/analysis/annotators/mfrc/annotators-llama-3-70b-single-improvement \
    logs/analysis/annotators/mfrc/annotators-llama-2-70b-single-improvement \
    logs/analysis/annotators/mfrc/annotators-gpt-3.5-single-improvement \
    logs/analysis/annotators/mfrc/annotators-gpt-4o-single-improvement \
    logs/analysis/annotators/goemotions/annotators-llama-3-8b-single-improvement \
    logs/analysis/annotators/goemotions/annotators-llama-2-7b-single-improvement \
    logs/analysis/annotators/goemotions/annotators-llama-3-70b-single-prior5-improvement \
    logs/analysis/annotators/goemotions/annotators-llama-2-70b-single-improvement \
    logs/analysis/annotators/goemotions/annotators-gpt-3.5-single-improvement \
    logs/analysis/annotators/goemotions/annotators-gpt-4o-single-improvement \
    --name Llama-2-7b-chat-hf Meta-Llama-3-8b-Instruct Llama-2-70b-chat-hf Meta-Llama-3-70b-Instruct gpt-3.5-turbo gpt-4o-mini \
    --row-name MFRC GoEmotions --row-metric micro_f1 jaccard_score \
    --o logs/analysis/annotators/results
