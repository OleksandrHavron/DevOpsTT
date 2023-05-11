FROM python:3.9

RUN apt-get update && apt-get install -y \
    build-essential \
    libssl-dev \
    libffi-dev \
    python3-dev \
    git \

# ToDo: Download and build C library

WORKDIR /usr/src/app

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
# Path to the compiled library
ENV LD_LIBRARY_PATH=/usr/local/lib
CMD [ "python", "./app.py" ]