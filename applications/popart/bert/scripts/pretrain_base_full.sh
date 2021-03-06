#!/bin/sh

# Pre-train phase 1 (sequence length 128):
python bert.py --config configs/pretrain_base.json \
    --checkpoint-dir checkpoints/phase1 2>&1 | tee pretrain_phase1_log.txt

# Get the timestamped directory from the most recent run.
PHASE1_DIR=$(ls checkpoints/phase1 -1 | tail -n 1)

# Load checkpoint and run phase 2 (sequence length 384):
python bert.py --config configs/pretrain_base_384.json \
    --onnx-checkpoint checkpoints/phase1/$PHASE1_DIR/model.onnx \
    --checkpoint-dir checkpoints/phase2 2>&1 | tee pretrain_phase2_log.txt

# Final pre-training result will be in checkpoints/phase2/model.onnx
