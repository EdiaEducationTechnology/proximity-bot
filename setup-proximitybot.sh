#!/bin/sh -x

. cleanup.sh

# Making the environment for rmxbot
python3 -m venv --copies env

# Make a directory for bin
mkdir -p bin static data/{rmxbot,nlp,nltk_data}


git clone https://github.com/dbrtk/rmxbin.git bin/rmxbin

git clone https://github.com/dbrtk/rmx.git bin/rmx

git clone https://github.com/dbrtk/rmxbot-tpl.git bin/rmxbot-tpl

source env/bin/activate
pip install -U pip
pip install -r requirements.txt

cd sites/rmxbot_site
python manage.py collectstatic -l
cd -

python -m nltk.downloader stopwords -d data/nltk_data
python -m nltk.downloader punkt -d data/nltk_data
python -m nltk.downloader averaged_perceptron_tagger -d data/nltk_data
python -m nltk.downloader wordnet -d data/nltk_data

deactivate
