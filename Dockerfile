# Use a Linux-based Python image
FROM python:3.11-slim-buster

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set working directory
WORKDIR /app

# Install necessary build dependencies for dlib
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    libopenblas-dev \
    liblapack-dev \
    libjpeg-dev \
    libpng-dev \
    libtiff-dev \
    libatlas-base-dev \
    gfortran \
    && rm -rf /var/lib/apt/lists/*

# Install dependencies for face_recognition
RUN pip install --no-cache-dir \
    numpy \
    scipy \
    scikit-image \
    pillow \
    click \
    face_recognition_models

# Install dlib
RUN pip install --no-cache-dir dlib

# Copy your application code into the container
COPY . .

CMD ["gunicorn", "--bind", "0.0.0.0:8000", "myproject.wsgi"]
