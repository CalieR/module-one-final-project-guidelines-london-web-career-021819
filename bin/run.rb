require_relative '../config/environment'
prompt = TTY::Prompt.new

# first thing to run is the title
title
menu(greeting)
