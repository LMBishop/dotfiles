import sys


def query_yes_no(question, default):
    if default == True:
        prompt = " [Y/n] "
    else:
        prompt = " [y/N] "

    sys.stdout.write(question + prompt)
    choice = input().lower()
    return True if choice == "y" else (False if choice == "n" else default)
