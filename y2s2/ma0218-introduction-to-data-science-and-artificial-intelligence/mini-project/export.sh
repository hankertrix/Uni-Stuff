rm -f ma-1-mini-project.zip notebook.html slides.html
marimo export html main.py --no-sandbox --include-code -o notebook.html || true
marimo export html main.py --no-sandbox --no-include-code -o slides.html || true
7z a -tzip ma-1-mini-project.zip ./* -x!.gitignore -x!*.tex -x!*.org -x!*.sh \
	-x!images -x!.git -x!__pycache__
