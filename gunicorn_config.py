# Customise these settings to your needs
bind = '0.0.0.0:5000'
daemon = False
accesslog = '/log/access_log'
errorlog = '/log/error_log'
#accesslog = '-'
#errorlog = '-'
loglevel = 'debug'
pidfile = 'sygnal.pid'
worker_connections = 1000
keepalive = 2
proc_name = 'sygnal'

# It is inadvisable to change anything below here,
# since these settings make gunicorn work appropriately
# with sygnal.

preload_app = False
workers = 1
worker_class = 'gevent'


def worker_exit(server, worker):
    # Used in the hooks
    try:
        # This must be imported inside the hook or it won't find
        # the import
        import sygnal
    except:
        # We swallow this exception because it's generally a completely
        # useless, "No module named sygnal" due to it failing to load
        # the sygnal module because an exception was thrown.
        print "Failed to load sygnal - check your log file"
    # NB. We obviously need to clean up in the worker, not
    # the arbiter process. worker_exit runs in the worker
    # (despite the docs claiming it runs after the worker
    # has exited)
    # We use a flask hook to handle the worker setup.
    # Unfortunately flask doesn't have a shutdown hook
    # (it's not a standard thing in WSGI).
    sygnal.shutdown()

