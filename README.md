docker-mumble-server
====================

This is a Docker container for running [Murmur](http://wiki.mumble.info/wiki/Main_Page), the server for the Mumble voice-over-ip client.

Environment
-----------

$UIDd = 501 (UID to run murmurd)
$GIDd = 501 (GID to run murmurd)

Usage
-----
Pull source

Run
`docker build -t <image name> .`

To initialize the server configuration, run this:

`docker run --name=mumble-server -d --net=host -v /path/to/config/mumble-server:/data <image name>`

The container will create a config file in /path/to/config/mumble-server. Edit the file, setting the server password and any welcome message.

Then start the container again and it will launch the server on port 64738:

`docker start mumble-server`

The log file will be created in /path/to/config/mumble-server/mumble-server.log, and the sqlite DB will be created in that directory as well.
