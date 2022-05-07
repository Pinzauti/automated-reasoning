"""
entrypoint
"""
import argparse

def main():
    pass

def init():
    """
    It collects the arguments to pass to the main function, which is then called.
    :return: None.
    """
    parser = argparse.ArgumentParser(description="Start the project.")
    parser.add_argument("tool",
                        choices=["asp", "minizinc"],
                        help="Choose between ASP and MiniZinc.")
    main(party=parser.parse_args().party)

init()