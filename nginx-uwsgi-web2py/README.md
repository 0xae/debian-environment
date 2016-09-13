# NGinx <-> uWSGI <-> web2py

This little guide aims to show you how to setup nginx and uwsgi to work

with web2py applications.

It so simple that it deserve a special place


## Begin

        # apt-get install nginx-full

        # pip install uwsgi

        # apt-get install uwsgi-plugin-python


## Configurations

Edit `nginx.conf` and `uwsgi.sh` and change

set the path to your web2py directory.

Run the following command to replace nginx default conf

        sudo cp nginx.conf /etc/nginx

## Start the servers

        sudo ./uwsgi.sh start
        sudo service nginx start

## Stop the servers
        sudo ./uwsgi.sh stop
        sudo service nginx stop
