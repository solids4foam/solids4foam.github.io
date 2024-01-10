#!/bin/bash

(cd solids4foam && git pull && cd .. && git add solids4foam && git commit -m "Update solids4foam commit" && git push)
