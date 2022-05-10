"""
Here are the main function to generate random instances, to load manually inserted instances, and to execute the models
in APS and Minizinc.
"""
import argparse
import random
import re
import clingo


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


def asp_manual(solutions_number):
    """
    Manual instances for ASP. You can modify the input file located in asp/data/input.lp.
    :param solutions_number: choose if you want to see all solutions or just the first one.
    :return: None.
    """
    ctl = clingo.Control()
    ctl.configuration.solve.models = solutions_number if solutions_number else 0
    ctl.add("base", [], """\
        #include "asp/data/input.lp". 
        #include "asp/model.lp". 
        """)
    ctl.ground([("base", [])])
    if "UNSAT" in str(ctl.solve(on_model=asp_prettier)):
        print("No solution found. \n")


def asp_random(user_dimension, number, solutions_number):
    """
    Random instances for ASP. A random instance is generated and printed in an human readable way. It includes the
    dimension of the board, the number of starting points, the position of the points and the turns they have to make.
    For obvious reasons not all instances will have a solution.
    :param number: the number of starting points defined by the user, used in random mode.
    :param user_dimension: the dimension of the board defined by the user, used in random mode.
    :param solutions_number: choose if you want to see all solutions or just the first one.
    :return: None.
    """
    if user_dimension:
        dimension = user_dimension
    else:
        dimension = random.randint(3, 5)

    def casual(turns=False, number_of_starting_points=False):
        """
        Generate a random number.
        :param turns: if the number is for the turn this can be also 0, and maximum the dimension of the board.
        :param number_of_starting_points: if the number is for the number of starting points those have to be at least
        two.
        :return: the random number.
        """
        if turns:
            return random.randint(0, dimension)
        if number_of_starting_points:
            if number:
                return number
            else:
                return random.randint(2, dimension)
        return random.randint(1, dimension)

    ctl = clingo.Control()
    ctl.configuration.solve.models = solutions_number if solutions_number else 0
    boardl = f"boardl({dimension})."
    starting_points = ""
    model = """#include "asp/model.lp"."""
    for _ in range(0, casual(number_of_starting_points=True)):
        starting_points += f"number({casual()},{casual()},{casual(turns=True)})."
    ctl.add("base", [], boardl + starting_points + model)
    ctl.ground([("base", [])])
    print(f'\nThe dimension of the board is {dimension}. \n')
    print(f'The starting points are: \n')
    for starting_point in starting_points[:-1].split('.'):
        print(f'{starting_point} \n')
    if "UNSAT" in str(ctl.solve(on_model=asp_prettier)):
        print("No solution found. \n")


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

    if dimension  and dimension < 2:
        print("The dimension of the board must be at least 2. \n")
        return
    elif dimension and dimension > 7:
        print("Better not to go above seven. \n")
        return

    if number and number < 2:
        print("The number of starting points must be at least 2. \n")
        return

    if tool == "asp":
        if mode == "manual":
            asp_manual(solutions_number)
        elif mode == "random":
            asp_random(dimension, number, solutions_number)

    elif tool == "minizinc":
        pass


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
                        choices=["asp", "minizinc"],
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
