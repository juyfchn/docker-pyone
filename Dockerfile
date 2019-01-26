FROM python:2.7.15-jessie

COPY start.sh aria2c aria2.conf /

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5 && \
    echo "deb http://repo.mongodb.org/apt/debian jessie/mongodb-org/3.6 main" | tee /etc/apt/sources.list.d/mongodb-org-3.6.list && \
    apt-get update && \
    apt-get install -y mongodb-org redis-server vim && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /root/PyOne.sample /root/PyOne /data/db /data/log /data/aria2/download && \
    touch /data/aria2/aria2.session && \
    mv /aria2c /usr/local/bin && \
    mv /aria2.conf /data/aria2/aria2.conf && \
    chmod +x /start.sh /usr/local/bin/aria2c && \
    git clone https://github.com/abbeyokgo/PyOne.git /root/PyOne.sample && \
    pip install -r /root/PyOne.sample/requirements.txt

EXPOSE 34567

ENTRYPOINT ["/start.sh"]