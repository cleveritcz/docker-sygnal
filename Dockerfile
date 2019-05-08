FROM cleveritcz/debian9-slim

WORKDIR /app
ADD sygnal/. /app
ADD gunicorn_config.py /app/gunicorn_config.py

RUN pip install --trusted-host pypi.python.org gunicorn
RUN apt update && apt -y install file gcc libc6-dev
RUN python setup.py install || pip install gevent==1.4.0 && python setup.py install

RUN mkdir /log

EXPOSE 5000

# mount /app/sygnal.conf (and optionally override /app/gunicorn_config.py)
# also mount a log folder (for example, /log)
CMD ["gunicorn", "-c", "gunicorn_config.py", "sygnal:app"]

