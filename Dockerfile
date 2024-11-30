FROM python:3.11-slim-buster

LABEL maintainer="Jimmy chienfeng0719@hotmail.com"

ARG WORKDIR="app"
ARG POETRY_VERSION=1.8.1
RUN apt-get update
RUN apt-get install -y tzdata bash g++ gcc screen vim python3-dev git

ENV TZ=Asia/Taipei

RUN mkdir -p ${WORKDIR}
WORKDIR ${WORKDIR}

RUN pip install --upgrade pip && pip install "poetry==$POETRY_VERSION"

COPY poetry.lock pyproject.toml ./

RUN poetry export --without-hashes --no-interaction --no-ansi -f requirements.txt -o requirements.txt
RUN pip3 install --no-cache-dir -r requirements.txt && rm requirements.txt

RUN echo 'alias start="uvicorn start_api:app --reload --proxy-headers --forwarded-allow-ips \"*\" --host 0.0.0.0 --port 5000"' >> /root/.bashrc
RUN echo 'alias run="uvicorn start_api:app --proxy-headers --forwarded-allow-ips \"*\" --host 0.0.0.0 --port 5000"' >> /root/.bashrc

