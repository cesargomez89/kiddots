function llama-serve() {
  local model="unsloth/Qwen3.5-9B-GGUF:Q4_K_M"
  local port="${1:-8080}"

  llama-server \
    -hf "$model" \
    --port "$port" \
    --jinja \
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
