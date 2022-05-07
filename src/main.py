"""
entrypoint
"""
import argparse
import random
from clingo.control import Control
from clingo.symbol import Function
from clingo.symbol import Number

def main(tool):

    dimension = 3

    def casual(turn = False):
        if turn:
            return Number(random.randint(0, dimension - 2))
        return Number(random.randint(1, dimension))

    def on_model(m):
     print (m)

    ctl = Control()
    ctl.add("base", ["n"], 'boardl(n).')
    ctl.add("base", ["a", "b", "c"], "number(a,b,c).")
    ctl.add("base", [], """#include "asp/main.lp". """)

    ctl.ground([("base", [])])
    ctl.ground([("base", [Number(dimension)])])
    ctl.ground([("base", [casual(), casual(), casual(True)]) for i in range(random.randint(2, dimension))])
    print(ctl.solve(on_model=on_model))

def init():
    """
    It collects the arguments to pass to the main function, which is then called.
    :return: None.
    """
    parser = argparse.ArgumentParser(description="Start the project.")
    parser.add_argument("tool",
                        choices=["asp", "minizinc"],
                        help="Choose between ASP and MiniZinc.")
    main(tool=parser.parse_args().tool)

init()