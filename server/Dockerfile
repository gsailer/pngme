FROM python:3.8.1-buster

WORKDIR /usr/pngme

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# copy requirements file
COPY ./requirements.txt /usr/pngme/requirements.txt

RUN set -eux && pip install --upgrade pip setuptools wheel && pip install -r /usr/pngme/requirements.txt

COPY . /usr/pngme
CMD ["uvicorn", "app.main:app", "--reload", "--proxy-headers", "--workers", "1", "--host", "0.0.0.0", "--port", "8000"]
