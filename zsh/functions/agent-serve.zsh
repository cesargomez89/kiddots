# function agent-serve() {
#   local model="unsloth/gemma-4-12B-it-qat-GGUF:UD-Q4_K_XL"
#   local port="${1:-8082}"
#
#   # The MTP drafter (mtp-gemma-4-12B-it.gguf) lives in the same repo and
#   # should auto-download with -hf. If not, download it and pass
#   # --model-draft <path>. Tune --spec-draft-n-max between 1 and 6.
#   llama-server \
#     -hf "$model" \
#     --port "$port" \
#     -fitt 700 \
#     -c 131072 \
#     -n 16384 \
#     -fa on \
#     -np 1 \
#     -ctk q8_0 \
#     -ctv q8_0 \
#     -ctkd q8_0 \
#     -ctvd q8_0 \
#     -ctxcp 64 \
#     -b 2048 \
#     -ub 2048 \
#     -lm none \
#     --no-mmproj \
#     --spec-type draft-mtp \
#     --spec-draft-n-max 4 \
#     --spec-draft-p-min 0.7 \
#     --reasoning on \
#     --chat-template-kwargs '{"enable_thinking": true}' \
#     --temp 1.0 \
#     --top-p 0.95 \
#     --top-k 64
# }

function agent-serve-64k() {
  local model="unsloth/gemma-4-26B-A4B-it-qat-GGUF:UD-Q4_K_XL"
  local port="${1:-8082}"

  llama-server \
    -hf "$model" \
    --port "$port" \
    -fitt 1024 \
    -c 65536 \
    -n 16384 \
    -fa on \
    -np 1 \
    -ctk q8_0 \
    -ctv q8_0 \
    -ctkd q8_0 \
    -ctvd q8_0 \
    -ctxcp 64 \
    -b 2048 \
    -ub 2048 \
    -lm none \
    --no-mmproj \
    --spec-type draft-mtp \
    --spec-draft-n-max 3 \
    --spec-draft-p-min 0.7 \
    --reasoning on \
    --chat-template-kwargs '{"enable_thinking": true}' \
    --temp 1.0 \
    --top-p 0.95 \
    --top-k 64
}

function agent-serve-128k() {
  local model="unsloth/gemma-4-26B-A4B-it-qat-GGUF:UD-Q4_K_XL"
  local port="${1:-8082}"

  llama-server \
    -hf "$model" \
    --port "$port" \
    -fitt 1024 \
    -c 131072 \
    -n 16384 \
    -fa on \
    -np 1 \
    -ctk q8_0 \
    -ctv q8_0 \
    -ctkd q8_0 \
    -ctvd q8_0 \
    -ctxcp 64 \
    -b 2048 \
    -ub 2048 \
    -lm none \
    --no-mmproj \
    --spec-type draft-mtp \
    --spec-draft-n-max 2 \
    --spec-draft-p-min 0.7 \
    --reasoning on \
    --chat-template-kwargs '{"enable_thinking": true}' \
    --temp 1.0 \
    --top-p 0.95 \
    --top-k 64
}
