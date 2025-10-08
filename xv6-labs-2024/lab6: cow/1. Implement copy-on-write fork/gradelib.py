def show_command(cmd):
#     from pipes import quote
    from shlex import quote
    print("\n$", " ".join(map(quote, cmd)))