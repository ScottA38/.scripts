#!/usr/bin/env bash

complete -W "$(docker ps -a --format \"{{.Names}}\" | xargs)" dockimgselect