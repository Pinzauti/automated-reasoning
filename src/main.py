"""
entrypoint
"""
import argparse
import random
import re
from clingo.control import Control
from clingo.symbol import Function
from clingo.symbol import Number


def on_model(m):
     
     goal_point = re.match(r'goal\(\d,\d\)', str(m))
     links = re.findall(r'link\(start\(\d,\d\),end\(\d,\d\)\)', str(m))

     if goal_point:
         print("The intersecion point is: ") 
         print(goal_point.group() + "\n")
     
     if links:
        print("The links to get to the intersecion points are the following: \n")
        for link in links:
            print(link + '\n')


def main(tool):

    dimension = 3

    def casual(turn = False):
        if turn:
            return Number(random.randint(0, dimension - 2))
        return Number(random.randint(1, dimension))

    ctl = Control()
    ctl.add("base", [], """\
        boardl(3).
        number(1,1,1). number(2,1,1). number(3,3,0).
    #include "asp/main.lp". """)

    ctl.ground([("base", [])])    
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