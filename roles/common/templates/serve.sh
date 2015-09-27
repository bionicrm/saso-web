#!/bin/bash

cd {{ app.dir }}
{{ rbenv.shims }}/rails server -b 0.0.0.0 -e development "$@"
