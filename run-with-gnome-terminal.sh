#!/bin/sh -x

# path to the 'activate' script (for the virtual environment)
ACTIVATE=env/bin/activate

# port for rmxbot
RPORT=8000

# port for nlp
NPORT=8001

# port for scrasync
SPORT=8002

# start mongodb
sudo systemctl start mongod.service

# start redis
sudo systemctl start redis.service

gnome-terminal \
    --tab --command \
    "bash -c 'source $ACTIVATE && cd sites/rmxbot_site; python manage.py runserver $RPORT; $SHELL'" \
    --tab --command \
    "bash -c 'source $ACTIVATE && cd sites/rmxbot_site; celery -A rmxbot_site worker --loglevel=info; $SHELL'" \
    --tab --command \
    "bash -c 'source $ACTIVATE && cd sites/nlp_site; python manage.py runserver $NPORT; $SHELL'" \
    --tab --command \
    "bash -c 'source $ACTIVATE && cd sites/nlp_site; celery -A nlp_site worker --loglevel=info; $SHELL'" \
    --tab --command \
    "bash -c 'source $ACTIVATE && cd sites/scrasync_site; python manage.py runserver $SPORT; $SHELL'"\
    --tab --command \
    "bash -c 'source $ACTIVATE && cd sites/scrasync_site; celery -A scrasync_site worker --loglevel=info; $SHELL'"
