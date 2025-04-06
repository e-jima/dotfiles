#/bin/bash

cd && uv venv --prompt '%F{009}Lilja%f'
uv pip install -r $ZDOTDIR/uv/requirements.txt
