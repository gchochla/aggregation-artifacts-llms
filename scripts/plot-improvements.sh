#!/bin/bash


for markers in "" "--diff-markers"; do

if [ "$markers" == "" ]; then
    fn=""
    suffix="None"
    cot_suffix="cot"
else
    fn="-full"
    suffix="full"
    cot_suffix="cot-full"
fi

python scripts/annotator-pull/plot_improvements.py \
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
    --row-name MFRC GoEmotions --row-metric micro_f1 jaccard_score $markers --fn-suffix $suffix \
    --o "logs/analysis/annotators/results${fn}" --type prior --title "Relative Posterior Improvement of Annotators with ICL"

python scripts/annotator-pull/plot_improvements.py \
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
    --row-name MFRC GoEmotions --row-metric micro_f1 jaccard_score $markers --fn-suffix $suffix \
    --o "logs/analysis/annotators/results${fn}" --type prior-abs --title "Annotator Performance with ICL"

python scripts/annotator-pull/plot_improvements.py \
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
    --row-name MFRC GoEmotions --row-metric micro_f1 jaccard_score $markers --fn-suffix $suffix \
    --o "logs/analysis/annotators/results${fn}" --type aggr --title "Relative Posterior Improvement of Annotators with ICL"

python scripts/annotator-pull/plot_improvements.py \
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
    --row-name MFRC GoEmotions --row-metric micro_f1 jaccard_score $markers --fn-suffix $suffix \
    --o "logs/analysis/annotators/results${fn}" --type aggr-abs --title "Annotator Performance with ICL"

python scripts/annotator-pull/plot_improvements.py \
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
    --row-name MFRC GoEmotions --row-metric micro_f1 jaccard_score $markers --fn-suffix $suffix \
    --o "logs/analysis/annotators/results${fn}" --type prior-aggr --title "Annotator Similarity with Prior wrt Annotator Similarity with Aggregate"

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
    --row-name MFRC GoEmotions --row-metric micro_f1 jaccard_score $markers --fn-suffix $cot_suffix \
    --o "logs/analysis/annotators/cot-results${fn}" --type prior --title "Relative Posterior Improvement of Annotators with CoT"

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
    --row-name MFRC GoEmotions --row-metric micro_f1 jaccard_score $markers --fn-suffix $cot_suffix \
    --o "logs/analysis/annotators/cot-results${fn}" --type prior-abs  --title "Annotator Performance with CoT"

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
    --row-name MFRC GoEmotions --row-metric micro_f1 jaccard_score $markers --fn-suffix $cot_suffix \
    --o "logs/analysis/annotators/cot-results${fn}" --type aggr --title "Relative Posterior Improvement of Annotators with CoT"

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
    --row-name MFRC GoEmotions --row-metric micro_f1 jaccard_score $markers --fn-suffix $cot_suffix \
    --o "logs/analysis/annotators/cot-results${fn}" --type aggr-abs --title "Annotator Performance with CoT"

done