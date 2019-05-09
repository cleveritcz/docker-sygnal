FROM python:2.7-slim

WORKDIR /app
ADD sygnal/. /app
ADD gunicorn_config.py /app/gunicorn_config.py

RUN pip install --trusted-host pypi.python.org gunicorn==19.9 gevent==1.4.0 requests==2.21 && python setup.py install
RUN mkdir /log
RUN touch /log/error_log && chown -R gunicorn:gunicorn /log

#RUN apt update && apt -y install file gcc libc6-dev

RUN pip 

EXPOSE 5000

# mount /app/sygnal.conf (and optionally override /app/gunicorn_config.py)
# also mount a log folder (for example, /log)
CMD ["gunicorn", "-c", "gunicorn_config.py", "sygnal:app"]

