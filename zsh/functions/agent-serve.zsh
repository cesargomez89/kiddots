function agent-serve() {
  local model="unsloth/Qwen3.6-35B-A3B-MTP-GGUF"
  local port="${1:-8082}"

  llama-server \
    -hf "$model" \
    --port "$port" \
    -fitt 800 \
    -c 65536 \
    -n 16384 \
    -fa on \
    -np 1 \
    --n-cpu-moe 16 \
    -ctk q8_0 \
    -ctv q8_0 \
    -ctkd q8_0 \
    -ctvd q8_0 \
    -ctxcp 64 \
    -b 1024 \
    -ub 1024 \
    --no-mmap \
    --no-mmproj \
    --spec-type draft-mtp \
    --spec-draft-n-max 2 \
    --chat-template-kwargs '{"preserve_thinking": true}' \
    --temp 0.6 \
    --top-p 0.95 \
    --top-k 20 \
    --min-p 0.0 \
    --presence-penalty 0.0 \
    --repeat-penalty 1.0
  }
