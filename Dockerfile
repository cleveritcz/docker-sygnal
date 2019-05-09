FROM python:2.7-slim

WORKDIR /app
ADD sygnal/. /app
ADD gunicorn_config.py /app/gunicorn_config.py

RUN pip install --trusted-host pypi.python.org gunicorn==19.9 gevent==1.4.0 requests==2.21 && python setup.py install
RUN mkdir /log
RUN touch /log/error_log && chmod 775 -R /log

EXPOSE 5000

# mount /app/sygnal.conf (and optionally override /app/gunicorn_config.py)
# also mount a log folder (for example, /log)
CMD ["gunicorn", "-c", "gunicorn_config.py", "sygnal:app"]

