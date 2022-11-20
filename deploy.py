#!/usr/bin/python3
import os

from util.runners import run_step
from util.exceptions import StepFailedError
from util.helpers import check_preconditions
from util.prompt import query_yes_no

import yaml
from termcolor import colored

CWD = os.getcwd()


def get_sections_meeting_preconditions(yaml):
    sections = {}
    for key, section in yaml["sections"].items():
        if not check_preconditions(section):
            continue

        sections[key] = section

    return sections


def run_section(title, section):
    os.chdir(CWD)
    if "directory" in section:
        os.chdir(section["directory"])
    elif os.path.exists(title):
        os.chdir(title)

    for step in section["steps"]:
        if not check_preconditions(step):
            continue

        run_step(step)


with open("info.yml", "r") as f:
    yaml = yaml.safe_load(f)

sections = get_sections_meeting_preconditions(yaml)

print("Sections to run: " + ", ".join(
    map(lambda x: colored(x, "green"), sections.keys())
))
print()

if not query_yes_no("Proceed with install?", False):
    exit(1)

section_count = 0
total = len(sections.keys())
notes = {}
for key, section in sections.items():
    section_count += 1
    print(colored(f"[{section_count}/{total}] ", "white", attrs=["bold"])
          + "Section "
          + colored(key, "green"))
    try:
        run_section(key, section)
        if "notes" in section:
            notes[key] = section["notes"]
    except StepFailedError as e:
        print(colored("Step failed: ", "red") + str(e))
    print()

if len(notes) > 0:
    print(colored(f"[Notes]", "white", attrs=["bold"]))
    print()
    for key, note in notes.items():
        print("From " + colored(key, "green") + ":")
        for message in note:
            print(f"- {message}")
        print()
