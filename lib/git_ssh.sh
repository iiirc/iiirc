#!/bin/sh
exec ssh -o User=sqale -o IdentityFile=~/.ssh/iiirc.id_rsa "$@"
