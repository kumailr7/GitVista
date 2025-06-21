import os
import sys
from dotenv import load_dotenv
from google import genai  # ✅ use the correct modern library

def load_api_key():
    """Load API key from .env and strip accidental quotes."""
    load_dotenv()
    api_key = os.getenv("API_KEY")
    if not api_key:
        print("❌ API key not found. Please set it in the .env file.")
        sys.exit(1)
    # Remove accidental quotes if present
    api_key = api_key.strip('"').strip("'")
    return api_key

# get_gemini_help.py
def create_prompt(command):
    """Create a structured prompt for Gemini."""
    return f"""
Provide a short description and an example for the Git command: {command}.

1. **What is `{command}`?**
- A clear and concise explanation.

2. **Example of `{command}`:**
- Provide an example usage.
"""

def get_help(command):
    """Call Gemini and get the result."""
    api_key = load_api_key()
    client = genai.Client()
    prompt = create_prompt(command)
    response = client.models.generate_content(
        model="gemini-2.0-flash",
        contents=prompt
    )
    return response.text

def main():
    """CLI entry point."""
    if len(sys.argv) != 2:
        print("Usage: python get_gemini_help.py <git-command>")
        sys.exit(1)

    command = sys.argv[1]
    result = get_help(command)
    print("\n✅ Gemini says:\n")
    print(result)

if __name__ == "__main__":
    main()
