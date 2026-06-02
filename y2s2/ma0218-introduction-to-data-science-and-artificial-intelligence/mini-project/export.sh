#!/bin/sh

# Install all the dependencies
uv sync

# Source the environment
. .venv/bin/activate

# Remove the old files
rm -f ma-1-mini-project.zip notebook.html slides.html

# Export the notebooks
marimo export html main.py --no-sandbox --include-code -o notebook.html
marimo export html main.py --no-sandbox --no-include-code -o slides.html

# Add everything to the zip file
7z a -tzip ma-1-mini-project.zip ./* -x!.gitignore -x!*.tex -x!*.org -x!*.sh \
	-x!images -x!.git -x!__pycache__
