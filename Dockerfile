FROM mcr.microsoft.com/windows/servercore:ltsc2019 

WORKDIR /app

COPY dlib-19.24.1-cp311-cp311-win_amd64.whl .  

RUN pip install dlib-19.24.1-cp311-cp311-win_amd64.whl  



FROM python:3.9-slim

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1


WORKDIR /app

COPY requirements.txt requirements.txt

RUN pip3 install -r requirements.txt

COPY . .

CMD ["gunicorn", "--bind", "0.0.0.0:8000", "myproject.wsgi"]



