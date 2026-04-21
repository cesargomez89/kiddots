function completion-serve() {
  local model="unsloth/Qwen3.5-9B-GGUF:Q4_K_M"
  local port="${1:-8081}"

  llama-server \
    -hf "$model" \
    --port "$port" \
    -ngl 99 \
    -c 131072 \
    -n 16384 \
    -fa on \
    -ctk q4_0 \
    -ctv q4_0 \
    -b 2048 \
    -ub 512 \
    --temp 1.0 --top-k 20 --top-p 0.99
}

function agent-serve() {
  local model="unsloth/Qwen3.6-35B-A3B-GGUF:UD-Q4_K_M"
  local port="${1:-8082}"

  ulimit -l unlimited

  llama-server \
    -hf "$model" \
    --port "$port" \
    --no-mmproj \
    --fit on \
    --fit-ctx 32768 \
    --fit-target 1200 \
    --n-cpu-moe 17 \
    -np 1 \
    -fa on \
    --no-mmap \
    --mlock \
    -b 2048 \
    -ub 1024 \
    -ctk q8_0 \
    -ctv q8_0 \
    -t 8 \
    --temp 0.6 \
    --top-p 0.95 \
    --min-p 0.05 \
    --reasoning-budget -1 \
    --chat-template-kwargs "{\"preserve_thinking\": true}"
}
