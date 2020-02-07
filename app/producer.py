import time
import os

from confluent_kafka import Producer


p = Producer({'bootstrap.servers': 'broker:29092'})

topic = os.getenv('TOPIC')

def delivery_report(err, msg):
    if err is not None:
        print('Message delivery failed: {}'.format(err))
    else:
        print('Message delivered to {} [{}]'.format(msg.topic(), msg.partition()))

while True:
    current_time = time.strftime("%H:%M:%S")

    p.produce(
        topic=topic, 
        key=current_time,
        value='Current time is: ' + current_time, 
        callback=delivery_report
    )

    time.sleep(1)
    p.flush()
