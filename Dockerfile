FROM python:3.9-slim

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

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
    libx11-dev \
    && apt-get install -y libavdevice-dev libavfilter-dev libavformat-dev libavcodec-dev libswresample-dev libswscale-dev libavutil-dev \
    && rm -rf /var/lib/apt/lists/*


# Install Python dependencies
RUN pip install numpy opencv-python

# Install dlib with reduced build options to save resources
RUN pip install dlib --no DLIB_USE_CUDA

WORKDIR /app

COPY requirements.txt requirements.txt

RUN pip3 install -r requirements.txt

COPY . .

CMD ["gunicorn", "--bind", "0.0.0.0:8000", "myproject.wsgi"]



