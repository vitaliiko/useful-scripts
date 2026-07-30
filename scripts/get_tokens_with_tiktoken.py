#!/usr/bin/env python3
"""
Script to tokenize a user-provided string using the tiktoken library.
Prints token IDs and the number of tokens.
"""

import sys
try:
    import tiktoken
except ImportError:
    print("tiktoken library not found. Install it with: pip install tiktoken", file=sys.stderr)
    sys.exit(1)

# Use default encoding (cl100k_base is common for OpenAI models)
ENCODING = "cl100k_base"

def main():
    user_input = input("Enter a string to tokenize: ")
    enc = tiktoken.get_encoding(ENCODING)
    tokens = enc.encode(user_input)
    print(f"Token IDs: {tokens}")
    print(f"Number of tokens: {len(tokens)}")

if __name__ == "__main__":
    main()

