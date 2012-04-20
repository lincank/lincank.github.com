#!/bin/sh
if [ ${1} == "r" ]; then
    bundle exec rake ${2}
elif [ ${1} == "n" ]; then
    bundle exec rake "new_post[${2}]"
elif [ ${1} == "np" ]; then
    bundle exec rake "new_page[${2}]"
fi