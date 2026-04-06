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
  local model="unsloth/gemma-4-26B-A4B-it-GGUF:UD-Q4_K_XL"
  local port="${1:-8082}"

  llama-server \
    -hf "$model" \
    --port "$port" \
    # -ngl 80 \
    -c 131072 \
    -n 16384 \
    -fa on \
    -ctk q4_0 \
    -ctv q4_0 \
    -b 2048 \
    -ub 512 \
    --temp 0.3 --top-k 20 --top-p 0.90 --min-p 0.1
}
