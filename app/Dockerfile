FROM python:3.6.8

COPY requirements.txt .
RUN pip install -qr requirements.txt

ADD producer.py /
ADD consumer.py /