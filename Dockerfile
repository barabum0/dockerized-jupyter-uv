FROM python:3.13-slim

RUN apt-get update && apt-get install -y curl git && rm -rf /var/lib/apt/lists/*

# Установка uv
RUN curl -LsSf https://astral.sh/uv/install.sh | sh && \
    mv /root/.cargo/bin/uv /usr/local/bin/uv

# Установка Jupyter (через uv)
RUN uv add jupyterlab

WORKDIR /workspace

VOLUME ["/workspace", "/root/.uv"]

# Токен задаём через ENV, дефолт — пустой (без токена)
ENV JUPYTER_TOKEN=""

CMD ["sh", "-c", "jupyter lab --ip=0.0.0.0 --allow-root --NotebookApp.token=$JUPYTER_TOKEN --NotebookApp.password='' --NotebookApp.allow_origin='*'"]
