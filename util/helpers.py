import os

OS_TYPE = os.getenv("OS_TYPE")


# Returns True if all preconditions pass
def check_preconditions(obj):
    if "preconditions" in obj:
        if ("os" in obj["preconditions"]
                and obj["preconditions"]["os"] != OS_TYPE):
            return False

    return True
