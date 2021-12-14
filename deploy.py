#!/usr/bin/python3
from os import listdir
from os.path import isfile, join, abspath 
from shutil import copy2 
from pathlib import Path

home = str(Path.home())
contents = dict()
directory = dict()

with open('directoryinfo') as f:
    lines = f.readlines()
    for line in lines:
        line = line.replace('%HOME', home)

        if (line.isspace()):
            continue

        if (line.startswith('#')):
            continue

        parts = line.split()
        if parts[0] == 'copycontent':
            contents[parts[1]] = parts[2]
        elif parts[0] == 'copyfulldir':
            directory[parts[1]] = parts[2]
        else:
            print(f'directoryinfo: unknown directive \'{parts[0]}\'')

# Directive: copycontent
for d, t in contents.items():
    files = [f for f in listdir(d) if isfile(join(d, f))]
    for file in files:
        print(f'Copying {abspath(join(d, file))} to {abspath(join(t, file))}')
        copy2(abspath(join(d, file)), join(t, file))

# Directive: copyfulldir
for d, t in directory.items():
    files = [f for f in listdir(d) if isfile(join(d, f))]
    print(f'Creating {t}')
    Path(t).mkdir(parents=True, exist_ok=True)
    for file in files:
        print(f'Copying {abspath(join(d, file))} to {join(t, file)}')
        copy2(abspath(join(d, file)), join(t, file))

