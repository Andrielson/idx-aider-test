#!/bin/bash

aider --architect --openai-api-base https://glhf.chat/api/openai/v1 --model openai/hf:deepseek-ai/DeepSeek-V2.5-1210 --editor-model openai/hf:deepseek-ai/DeepSeek-V2.5-1210 --editor-edit-format editor-diff --yes-always;