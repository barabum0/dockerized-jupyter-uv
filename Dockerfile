FROM ghcr.io/astral-sh/uv:python3.13-bookworm-slim AS builder
ENV UV_COMPILE_BYTECODE=1 UV_LINK_MODE=copy

# Disable Python downloads, because we want to use the system interpreter
ENV UV_PYTHON_DOWNLOADS=0

RUN uv init

# Установка Jupyter (через uv)
RUN uv add jupyterlab

WORKDIR /workspace

VOLUME ["/workspace", "/root/.uv"]

# Токен задаём через ENV, дефолт — пустой (без токена)
ENV JUPYTER_TOKEN=""

CMD ["sh", "-c", "jupyter lab --ip=0.0.0.0 --allow-root --NotebookApp.token=$JUPYTER_TOKEN --NotebookApp.password='' --NotebookApp.allow_origin='*'"]
