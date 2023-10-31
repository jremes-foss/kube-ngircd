#!/bin/sh
OPERATOR="\n[Operator]\n
Name = $1\n
Password = $(uuidgen)"
echo $OPERATOR >> ngircd.conf
