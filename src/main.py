"""
Here are the main function to generate random instances, to load manually inserted instances, and to execute the models
in APS and Minizinc.
"""
import argparse
from asp import asp_manual, asp_random
from mz import minizinc_manual, minizinc_random


def main(tool, mode, dimension, number, solutions_number):
    """
    Entrypoint of the program.
    :param solutions_number: choose if you want to see all solutions or just the first one.
    :param number: the number of starting points defined by the user, used in random mode.
    :param dimension: the dimension of the board defined by the user, used in random mode.
    :param tool: the tool to use, either ASP or MiniZinc.
    :param mode: if the input is manual or random.
    :return: None.
    """

    if dimension and dimension < 2:
        print("The dimension of the board must be at least 2. \n")
        return
    elif dimension and dimension > 6:
        print("Better not to go above seven. \n")
        return

    if number and number < 2:
        print("The number of starting points must be at least 2. \n")
        return
    elif number and number > 4:
        print("There can't be a valid intersection point with 5 points or more. \n")
        return

    if tool == "asp":
        if mode == "manual":
            asp_manual(solutions_number)
        elif mode == "random":
            asp_random(dimension, number, solutions_number)

    elif tool == "minizinc":
        if mode == "manual":
            minizinc_manual(solutions_number)
        elif mode == "random":
            minizinc_random(dimension, number, solutions_number)

    elif tool == "both":
        print("\nHere the solution for ASP: \n")
        asp_manual(solutions_number)
        print("\nHere the solution for MiniZinc: \n")
        minizinc_manual(solutions_number)


def init():
    """
    It collects the arguments to pass to the main function, which is then called.
    :return: None.
    """
    parser = argparse.ArgumentParser(
        description="In order to start the project choose between ASP and MiniZinc and between manual or random mode."
                    "If you want to use the random mode you can also choose the dimension and the number of starting"
                    "points")
    parser.add_argument('tool',
                        choices=["asp", "minizinc", "both"],
                        help="Choose between ASP and MiniZinc.")
    parser.add_argument('mode',
                        choices=["manual", "random"],
                        help="Choose if the input is manual or random.")
    parser.add_argument('-d',
                        '--dimension',
                        type=int,
                        help="Choose the dimension of the board.")
    parser.add_argument('-n',
                        '--number',
                        type=int,
                        help="Choose the number of starting points.")
    parser.add_argument('-s',
                        '--solutions',
                        type=int,
                        help="Choose the number of solutions you want to see.")
    main(
        tool=parser.parse_args().tool,
        mode=parser.parse_args().mode,
        dimension=parser.parse_args().dimension,
        number=parser.parse_args().number,
        solutions_number=parser.parse_args().solutions
    )


init()
