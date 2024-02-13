# Use a Windows-based Python image
FROM python:3.8-slim-buster

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set working directory
WORKDIR /app



# Copy dlib wheel from host to container (assuming you have it locally)
COPY dlib-19.24.1-cp38-cp38-win_amd64.whl dlib-19.24.1-cp38-cp38-win_amd64.whl

# Install dlib from the downloaded wheel
RUN pip install dlib-19.24.1-cp38-cp38-win_amd64.whl

# Install face_recognition and other Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy your application code to the container
COPY . .


CMD ["gunicorn", "--bind", "0.0.0.0:8000", "myproject.wsgi"]
