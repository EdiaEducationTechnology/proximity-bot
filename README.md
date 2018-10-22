# proximity-bot
Proximity-bot


3 servers (or environments) are needed to run proximity-bot, these include: 
* rmxbot - the server that handles http requests and makes the materials and graphs available to the public;
* scrasync - the web scraper;
* nlp - feature extraction algorithms with some text processing.

## requirements
Prroximity-bot requires Pyhton 3, Mongodb and Redis; all other dependencies will be installed automatically.

# Running proximity-bot locally (as a demo)
The easiest way is to run proximity-bot issuing the following commands:
```
git clone git@github.com:dbrtk/proximity-bot.git
cd proximitybot
. setup-proximitybot.sh
. run-with-gnome-terminal.sh

```
The commands above work on linux.
Then, the interface can be accessed under:

## http://localhost:8000/



## How to install proximity-bot manually
```
cd /opt
git@github.com:dbrtk/rmxbot.git
git@github.com:dbrtk/nlp.git
git@github.com:dbrtk/scrasync.git
git@github.com:dbrtk/rmxbin.git
git@github.com:dbrtk/rmxbot-tpl.git

python3 -m venv --copies env
. /opt/env/bin/activate
cd rmxbot
pip install -e .
cd ..

cd nlp
pip install -e . 
cd ..

cd scrasync
pip install -e .
cd ..

deactivate
```
Create 3 django projects that will be run on different ports, i.e. localhost:8080 for rmxbot, localhost:8081 for nlp, localhost:8082 for scrasync; each of these projects will need its own celery worker (using redis). Update the settings for every django project; the django project that hosts rmxbot should have a valid path under TEMPLATES DIRS. The templates for rmxbot can be found here: https://github.com/dbrtk/rmxbot-tpl.

The configuration files in rmxbot, scrasync, nlp should be updated as well:
* rmxbot - https://github.com/dbrtk/rmxbot/blob/master/rmxbot/config/__init__.py;
* nlp - https://github.com/dbrtk/nlp/blob/master/nlp/config/__init__.py;
* scrasyns - https://github.com/dbrtk/scrasync/blob/master/scrasync/config/__init__.py.

The README file for every applicaiton lists the variables that should be customised.
