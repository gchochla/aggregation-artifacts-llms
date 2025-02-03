#!/bin/bash


while getopts d:c: flag
do
    case "${flag}" in
        d) dir=${OPTARG};;
        c) cache=${OPTARG};;
    esac
done

python scripts/prompting/llm_prompting_clsf.py MFRC --root-dir $dir/mfrc \
    --train-split train --test-split dev test --annotation-mode both \
    --text-preprocessor false \
    --system ' ' --instruction $'Classify the following inputs into none, one, or multiple the following moral foundations per input: {labels}.\n' \
    --incontext $'Input: {text}\nEmotion(s): {label}\n' \
    --shot 5 25 45 --model-name meta-llama/Llama-2-7b-chat-hf meta-llama/Llama-2-70b-chat-hf meta-llama/Meta-Llama-3-8B-Intruct meta-llama/Meta-Llama-3-70B-Instruct \
    --cache-dir $cache --train-keep-same-examples --test-keep-same-examples \
    --train-debug-ann 3 --max-new-tokens 10 --seed 0 1 2 --test-debug-len 100 \
    { --keep-one-after-filtering true --label-mode _None_ distribution } \
    { --keep-one-after-filtering false } \
    --load-in-4bit --accelerate --logging-level debug \
    --alternative {model_name_or_path}-annotator-{keep_one_after_filtering}-{label_mode}-{shot}-shot

python scripts/prompting/llm_prompting_clsf.py MFRC --root-dir $dir/mfrc \
    --train-split train --test-split dev test --annotation-mode both \
    --text-preprocessor false \
    --system ' ' --instruction $'Classify the following inputs into none, one, or multiple the following moral foundations per input: {labels}.\n' \
    --incontext $'Input: {text}\nEmotion(s): {label}\n' \
    --shot 5 25 45 --model-name meta-llama/Llama-2-7b-chat-hf meta-llama/Llama-2-70b-chat-hf meta-llama/Meta-Llama-3-8B-Intruct meta-llama/Meta-Llama-3-70B-Instruct \
    --cache-dir $cache --train-keep-same-examples --test-keep-same-examples \
    --train-debug-ann 3 5 --max-new-tokens 10 --seed 0 1 2 --test-debug-len 100 \
    { --keep-one-after-filtering true --label-mode _None_ distribution } \
    { --keep-one-after-filtering false } \
    --load-in-4bit --accelerate --logging-level debug \
    --alternative {model_name_or_path}-annotator-{keep_one_after_filtering}-{label_mode}-{shot}-shot

