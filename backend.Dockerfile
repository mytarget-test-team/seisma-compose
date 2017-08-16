# Seisma backend server image

FROM python:3.5

COPY etc/seisma /etc/seisma
COPY init.d/backend /opt/entry_point
COPY src/seisma-server/ /usr/local/src/seisma-server

RUN apt-get update -qqy && apt-get install -y cron gcc make

COPY etc/seisma/cron.d/ /etc/cron.d

RUN apt-get install -y libreadline-gplv2-dev libncursesw5-dev \
    libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev

RUN pip install --egg -r /usr/local/src/seisma-server/requirements.txt -U && \
    rm -rf /usr/local/src/seisma-server

ENV SEISMA_SETTINGS /etc/seisma/seisma.py
ENV PYTHONPATH=/usr/local/src/seisma-server

WORKDIR /usr/local/src/seisma-server
