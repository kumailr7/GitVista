import os
import sys
from dotenv import load_dotenv
import google.generativeai as genai

def load_api_key():
    """Load the API key from the .env file."""
    load_dotenv()
    api_key = os.getenv("API_KEY")
    if not api_key:
        print("API key not found. Please set it in the .env file.")
        sys.exit(1)
    return api_key

def configure_model(api_key):
    """Configure and return the Generative Model instance."""
    genai.configure(api_key=api_key)
    return genai.GenerativeModel('gemini-1.5-pro')

def create_prompt(command):
    """Create and return the structured prompt."""
    return f"""
    Provide a short description and an example for the Git command: {command}.

    1. **What is {command}?**
    - A clear and concise explanation of what the command does.

    2. **Example of {command}:**
    - Provide an example usage of the command.
    """

def get_help(command):
    """Generate and return the solution for the given command."""
    api_key = load_api_key()
    model = configure_model(api_key)
    prompt = create_prompt(command)
    response = model.generate_content(prompt)
    return response.text

def main():
    """Main function to handle command-line arguments and print the solution."""
    if len(sys.argv) != 2:
        print("Usage: python get_gemini_help.py <command>")
        sys.exit(1)
    
    command = sys.argv[1]
    solution = get_help(command)
    print(solution)

if __name__ == "__main__":
    main()