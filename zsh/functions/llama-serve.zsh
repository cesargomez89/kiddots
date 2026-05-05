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

  llama-server \
    -hf "$model" \
    --port "$port" \
    --fit on \
    --fit-ctx 65536 \
    --fit-target 1300 \
    --no-mmproj \
    --n-cpu-moe 18 \
    --threads 12 \
    -np 1 \
    -fa on \
    --no-mmap \
    --mlock \
    -b 2048 \
    -ub 2048 \
    -ctk q8_0 \
    -ctv q8_0 \
    --temp 0.6 \
    --top-p 0.95 \
    --top-k 20 \
    --min-p 0.0 \
    --presence-penalty 0.0 \
    --repeat-penalty 1.0 \
    --reasoning-budget -1 \
    --chat-template-kwargs "{\"preserve_thinking\": true}" \
}
