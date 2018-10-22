#!/bin/sh -x

. cleanup.sh

# Making the environment for rmxbot
python3 -m venv --copies env

# Make a directory for bin
mkdir -p bin static data/{rmxbot,nlp}


git clone git@github.com:dbrtk/rmxbin.git bin/rmxbin

git clone git@github.com:dbrtk/rmx.git bin/rmx

git clone git@github.com:dbrtk/rmxbot-tpl.git bin/rmxbot-tpl

source env/bin/activate
pip install -U pip
pip install -r requirements.txt

cd sites/rmxbot_site
python manage.py collectstatic -l
cd -

python -m nltk.downloader stopwords -d bin/nltk_data
python -m nltk.downloader punkt -d bin/nltk_data
python -m nltk.downloader averaged_perceptron_tagger -d bin/nltk_data
python -m nltk.downloader wordnet -d bin/nltk_data

deactivate
