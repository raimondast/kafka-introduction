import time
import os

from confluent_kafka import Consumer, KafkaError

topic = os.getenv('TOPIC')

c = Consumer({
    'bootstrap.servers': 'broker:29092',
    'group.id': 'app-demo',
    'auto.offset.reset': 'earliest'
})

c.subscribe([topic])

while True:
    msg = c.poll(1.0)

    if msg is None:
        continue
    if msg.error():
        print("Consumer error: {}".format(msg.error()))
        continue

    print('Received message: {}'.format(msg.value().decode('utf-8')))
