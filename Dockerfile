FROM python:3.8-slim-buster

#ENV LANG C.UTF-8
#ENV DEBIAN_FRONTEND noninteractive

# OS update, then clean up
RUN apt-get -yq update && \
    apt-get -yq upgrade && \
    apt-get -yq --no-install-recommends install \
        tesseract-ocr \
        libtesseract-dev \
        libopenjp2-7-dev \
        python3 \
        python-paho-mqtt \
        python3-setuptools \
        python3-pip && \
    apt-get clean && \
    rm -rf /tmp/* /var/tmp/* /var/lib/apt/archive/* /var/lib/apt/lists/*





WORKDIR /server
COPY ./app /server/app
COPY requirements.txt /server

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN python3 -m pip install --upgrade pip
#RUN pip install --upgrade pip
RUN pip config set global.trusted-host "pypi.org files.pythonhosted.org pypi.python.org"

RUN pip install Pillow
RUN pip install -r requirements.txt

CMD ["python", "app/main.py"]