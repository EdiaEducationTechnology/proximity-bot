#!/bin/sh -x

echo 'db.dropDatabase()' | mongo rmx
rm -fr data/rmxbot/*
