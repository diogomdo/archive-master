#!/usr/bin/env python

import os

EXTENSIONS = '.log'
DIR = "../croupier/resources/logs/"

for root, dirs, files in os.walk(DIR):
    for file in files:
        if file.endswith(EXTENSIONS):
            fullpath = os.path.join(root, file)
            if len(file.split("-")[0]) < 8:
                with open(fullpath, "r") as f:
                    first_line = f.readline()

                new_name = first_line.split(" ")[0].replace("-", "")
                print("file: {0} was renamed.".format(file))

                os.rename(fullpath, os.path.join(root, new_name + "-output.log"))
