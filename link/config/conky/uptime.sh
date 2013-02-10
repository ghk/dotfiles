#!/bin/bash
uptime | sed -nr 's/.*\s+([[:digit:]]{1,2}):[[:digit:]]{2},.*/\1/p'
