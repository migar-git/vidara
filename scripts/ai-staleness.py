#!/usr/bin/env python3
"""
scripts/ai-staleness.py — Detect docs that have drifted from codebase
Usage: python3 scripts/ai-staleness.py [--path docs/03-architecture] [--threshold 0.7]
"""
import sys
import os
import glob
import pathlib
import argparse

try:
    import numpy as np
    import httpx
    HAS_DEPS = True
except ImportError:
    HAS_DEPS = False


def cosine_similarity(a, b):
    return np.dot(a, b) / (np.linalg.norm(a) * np.linalg.norm(b))


def get_embedding(text: str, model: str = "text-embedding-3-small") -> list:
    api_key = os.environ.get("AI_API_KEY")
    if not api_key:
        raise EnvironmentError("AI_API_KEY not set")
    resp = httpx.post(
        "https://api.openai.com/v1/embeddings",
        headers={"Authorization": f"Bearer {api_key}"},
        json={"input": text[:8000], "model": model},
        timeout=30,
    )
    resp.raise_for_status()
    return resp.json()["data"][0]["embedding"]


def main() -> None:
    parser = argparse.ArgumentParser(description="Detect stale myprd docs")
    parser.add_argument("--path", default="docs", help="Docs directory to scan")
    parser.add_argument("--threshold", type=float, default=0.7, help="Similarity threshold")
    args = parser.parse_args()

    if not HAS_DEPS:
        print("ERROR: install dependencies: pip install numpy httpx", file=sys.stderr)
        sys.exit(1)

    # Collect source code as comparison corpus
    src_text = ""
    for ext in ["**/*.py", "**/*.ts", "**/*.tsx"]:
        for f in glob.glob(ext, recursive=True):
            if "node_modules" not in f and ".venv" not in f and "venv" not in f:
                try:
                    src_text += pathlib.Path(f).read_text(errors="ignore")[:500]
                except OSError:
                    pass

    if not src_text.strip():
        print("No source files found — skipping staleness check")
        return

    src_embedding = get_embedding(src_text[:8000])

    print(f"Staleness Report — threshold={args.threshold} — {pathlib.Path(args.path).resolve()}")
    print("=" * 70)

    stale_count = 0
    for doc in sorted(pathlib.Path(args.path).rglob("*.md")):
        if doc.name.startswith("_") or "postmortem" in str(doc):
            continue
        text = doc.read_text(errors="ignore")
        doc_embedding = get_embedding(text[:8000])
        sim = cosine_similarity(src_embedding, doc_embedding)
        status = "FRESH" if sim >= args.threshold else "STALE"
        if status == "STALE":
            stale_count += 1
        print(f"{status}: {doc} — similarity {sim:.2f}")

    print(f"\n{stale_count} stale doc(s) found")


if __name__ == "__main__":
    main()
