FROM python:3.11-slim-buster

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1


WORKDIR /app

RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libopenblas-dev \
    liblapack-dev \
    libjpeg-dev \
    libpng-dev \
    libtiff-dev \
    zlib1g-dev \
    libgif-dev \
    libwebp-dev \
    libhdf5-dev \
    libboost-all-dev \
    && rm -rf /var/lib/apt/lists/*


RUN pip install --no-cache-dir \
    numpy \
    scipy \
    scikit-image \
    pillow \
    click \
    face_recognition_models



COPY . .

CMD ["gunicorn", "--bind", "0.0.0.0:8000", "myproject.wsgi"]
