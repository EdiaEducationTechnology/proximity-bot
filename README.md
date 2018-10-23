# proximity-bot

3 servers (or environments) are needed to run proximity-bot, these include: 
* rmxbot - the server that handles http requests and makes the materials and graphs available to the public;
* scrasync - the web scraper;
* nlp - feature extraction algorithms with some text processing.

These servers communicate using rsync, ssh and http. 

## requirements
Prroximity-bot requires Pyhton 3, Mongodb and Redis; python dependencies will be installed automatically. 

# Running proximity-bot locally (as a demo)
All the components that make proximity-bot can be ran on one machine, this section describes how to do that. 
The easiest way to run proximity-bot, it to issue the following commands:
```
git clone git@github.com:dbrtk/proximity-bot.git
cd proximity-bot
. setup-proximitybot.sh
. run-with-gnome-terminal.sh
```
The commands above work on linux; the following software is required: git, gnome-terminal, python3.
After these commands succeed and rmxbot, scrasync, nlp are all running, the interface can be accessed under:
## http://localhost:8000/




## Installing proximity-bot manually
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
