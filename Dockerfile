FROM mcr.microsoft.com/windows/servercore:ltsc2019

# Install Python 3.11
RUN mkdir C:\Python \
    && Invoke-WebRequest -Uri "https://www.python.org/ftp/python/3.11.1/python-3.11.1-amd64.exe" -OutFile python-installer.exe \
    && Start-Process python-installer.exe -ArgumentList "/quiet", "TargetDir=C:\Python", "/NoRegistryChecks" -Wait \
    && del python-installer.exe

# Set environment variables
ENV PATH="C:\Python;${PATH}"
ENV PYTHONPATH="C:\Python"

WORKDIR /app

# Copy and install application dependencies
COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copy application files
COPY . .


CMD ["gunicorn", "--bind", "0.0.0.0:8000", "myproject.wsgi"]



