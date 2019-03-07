#! /bin/bash

bundle install

rake db:migrate
rake db:seed
