"""
Here are the main function to generate random instances, to load manually inserted instances, and to execute the models in APS and Minizinc.
"""
import argparse
import clingo
import re
import random


def asp_prettier(m):
    """
    Prints the ASP result in a prettier and more comprehensible way.
    :param m: the model.
    :return: None.
    """
    goal_point = re.match(r'goal\(\d,\d\)', str(m))
    links = re.findall(r'link\(start\(\d,\d\),end\(\d,\d\)\)', str(m))

    if goal_point:
        print(f"An intersection point is: {goal_point.group()} \n")      
     
    if links:
        print("The links to get to the intersection point are the following: \n")
        for link in links:
            print(link + '\n')
       


def asp_manual():
    """
    Manual instances for ASP. You can modify the input file located in asp/data/input.lp.
    :return: None.
    """
    ctl = clingo.Control()
    ctl.configuration.solve.models = 0
    ctl.add("base", [], """\
        #include "asp/data/input.lp". 
        #include "asp/main.lp". 
        """)
    ctl.ground([("base", [])])
    if "UNSAT" in str(ctl.solve(on_model=asp_prettier)):
        print("No solution found. \n")


def asp_random():
    """
    Random instances for ASP. A random instance is generated and printed in an human readable way. It includes the dimension of the board, the number of starting points, the position of the points and the turns they have to make. For obvious reasons not all instances will have a solution.
    :return: None.
    """
    dimension = random.randint(3,5)
    def casual(turn = False, number_of_starting_points = False):
        """
        Generate a random number.
        :param turn: if the number is for the turn this can be also 0, and maximum the dimension of the board.
        :param number_of_starting_points: if the number is for the number of starting points those have to be at least two.
        :return: the random number.
        """
        if turn:
            return random.randint(0, dimension)
        if number_of_starting_points:
            return random.randint(2,dimension)
        return random.randint(1,dimension)

    ctl = clingo.Control()
    ctl.configuration.solve.models = 0
    boardl =  f"boardl({dimension})."
    starting_points = ""
    model = """#include "asp/main.lp"."""
    for _ in range(0, casual(number_of_starting_points=True)):
        starting_points += f"number({casual()},{casual()},{casual(turn=True)})."
    ctl.add("base", [], boardl + starting_points + model)
    ctl.ground([("base", [])])
    print(f'The dimension of the board is {dimension}. \n')
    print(f'The starting points are: \n')
    for starting_point in starting_points[:-1].split('.'):
        print(f'{starting_point} \n')
    if "UNSAT" in str(ctl.solve(on_model=asp_prettier)):
        print("No solution found. \n")


def main(tool, mode):
    """
    Entrypoint of the program.
    :param tool: the tool to use, either ASP or MiniZinc.
    :param mode: if the input is manual or random.
    :return: None.
    """

    if tool == "asp":
        if mode == "manual":
            asp_manual()
        elif mode == "random":
            asp_random()

    elif tool == "minizinc":
        pass


def init():
    """
    It collects the arguments to pass to the main function, which is then called.
    :return: None.
    """
    parser = argparse.ArgumentParser(description="In order to start the project choose between ASP and MiniZinc and between manual or random mode.")
    parser.add_argument('tool',
                        choices=["asp", "minizinc"],
                        help="Choose between ASP and MiniZinc.")
    parser.add_argument('mode',
                        choices=["manual", "random"],
                        help="Choose if the input is manual or random.")
    main(
        tool=parser.parse_args().tool,
        mode=parser.parse_args().mode,
        )

init()