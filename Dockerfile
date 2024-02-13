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
    libqt5opengl5-dev \
    && rm -rf /var/lib/apt/lists/* && apt-get clean

# Add CUDA repository
RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin && \
    mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600 && \
    apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/7fa2af80.pub && \
    echo "deb http://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/ /" >> /etc/apt/sources.list.d/cuda.list

# Add NVIDIA Machine Learning repository
RUN wget https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu2004/x86_64/nvidia-machine-learning-repo-ubuntu2004_1.0.0-1_amd64.deb && \
    dpkg -i nvidia-machine-learning-repo-ubuntu2004_1.0.0-1_amd64.deb && \
    apt-get update

# Install CUDA toolkit and cuDNN
RUN apt-get install -y --no-install-recommends \
    cuda \
    libcudnn8 \
    libcudnn8-dev \
    && rm -rf /var/lib/apt/lists/* && apt-get clean

RUN pip install --no-cache-dir numpy
RUN pip install face_recognition
RUN pip install dlib

COPY requirements.txt requirements.txt

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD ["gunicorn", "--bind", "0.0.0.0:8000", "myproject.wsgi"]
