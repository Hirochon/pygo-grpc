FROM python:3.10.0-buster

ENV PYTHONUNBUFFERED 1

WORKDIR /work

COPY requirements.txt /work/
RUN pip install --upgrade pip && \
    pip install -r requirements.txt
COPY ./ /work/

EXPOSE 8000