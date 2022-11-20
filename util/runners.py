import os
import re
from util.exceptions import StepFailedError

HOME = os.getenv("HOME")


def run_step(step):
    step_type = step["=="]

    if step_type == "run":
        do_run(step["command"])
    elif step_type == "link":
        do_link(step["from"], step["to"])


def do_run(command):
    print(f"! {command}")
    if not os.system(command) == 0:
        raise StepFailedError("Non-zero return code")


def do_link(source, destination):
    destination = re.sub(r"^~/", HOME + "/", destination)
    print(f"Linking {source} -> {destination}")
    try:
        os.link(source, destination)
    except OSError as e:
        if e.errno == 17:
            print(f"File {destination} already exists")
        else:
            raise StepFailedError("Link raised exeption: " + str(e)) from e
    except Exception as e:
        raise StepFailedError("Link raised exeption: " + str(e)) from e
