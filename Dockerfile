FROM python:3.6-alpine

RUN apk update && apk add --no-cache supervisor docker

RUN pip install --upgrade pip
RUN pip install --upgrade setuptools

ADD setup.py /tmp/setup.py
ADD requirements.txt /tmp/requirements.txt
COPY interceptor /tmp/interceptor

RUN cd /tmp && python setup.py install && rm -rf /tmp/interceptor /tmp/requirements.txt /tmp/setup.py
ADD start.sh /tmp/start.sh
RUN chmod +x /tmp/start.sh

ENTRYPOINT ["/tmp/start.sh"]