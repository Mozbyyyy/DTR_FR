FROM python:3.11-slim-buster

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

WORKDIR /app

RUN apt-get update && apt-get install -y \
    cmake \
    make \
    gcc \
    g++ \
    libgl1-mesa-glx \
    libglib2.0-0 \
    libzbar-dev \
    libopenblas-dev \
    liblapack-dev \
    libavdevice-dev \
    libavfilter-dev \
    libavformat-dev \
    libavcodec-dev \
    libswresample-dev \
    libswscale-dev \
    libavutil-dev \
    libatlas-base-dev \
    libatlas3-base \
    libhdf5-dev \
    libhdf5-103 \
    libqt5gui5 \
    libqt5core5a \
    libqt5test5 \
    libqt5widgets5 \
    libjpeg-dev \
    libpng-dev \
    libtiff-dev \
    libgtk-3-dev \
    libx11-dev \
    libboost-all-dev \
    libblas-dev \
    libffi-dev \
    libssl-dev \
    libopenblas-dev \
    liblapack-dev \
    liblapacke-dev \
    libjpeg62-turbo-dev \
    zlib1g-dev \
    libcanberra-gtk-module \
    libcanberra-gtk3-module \
    libqt5opengl5-dev && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

RUN pip install --no-cache-dir numpy
RUN pip install face_recognition
RUN pip install dlib

COPY requirements.txt requirements.txt

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD ["gunicorn", "--bind", "0.0.0.0:8000", "myproject.wsgi"]


