#!/bin/sh -x

. cleanup.sh

# Making the environment for rmxbot
python3 -m venv --copies env

# Make a directory for bin
mkdir -p bin static data/{rmxbot,nlp}

git clone -b local_use git@github.com:dbrtk/rmxbot.git bin/rmxbot

git clone -b local_use git@github.com:dbrtk/scrasync.git bin/scrasync

git clone -b local_use git@github.com:dbrtk/nlp.git bin/nlp

git clone git@github.com:dbrtk/rmxbin.git bin/rmxbin

git clone git@github.com:dbrtk/rmx.git bin/rmx

git clone git@github.com:dbrtk/rmxbot-tpl.git bin/rmxbot-tpl

source env/bin/activate
pip install -U pip

for item in rmxbot nlp scrasync
do
    cd bin/$item; pwd
    pip install -e .
    cd -
done

cd sites/rmxbot_site
python manage.py collectstatic -l
cd -

deactivate
