#/bin/zsh

cd && uv venv --prompt "%F{009}$USER%f"
uv pip install -r $ZDOTDIR/uv/requirements.txt
