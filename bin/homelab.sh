#!/usr/bin/env bash

set -xe

export ROOT_DIR=$(pwd)
export PYTHON=$ROOT_DIR/.venv/bin/python

export SHELL=/bin/bash


echo $ROOT_DIR "\n"


docker compose --project-directory "$ROOT_DIR" --profile all  $@