"""
Everything related to ASP (e.g. prettify the result, generate random instances etc.) is contained in this file.
"""
import clingo
import random
import re


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
    Random instances for ASP. A random instance is generated and printed in a human-readable way. It includes the
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
        :param turns: if the number is for the turn this can be minimum 0 and maximum the dimension of the board.
        :param number_of_starting_points: if the number is for the number of starting points those have to be at least
        two and can be maximum 4.
        :return: the random number.
        """
        if turns:
            return random.randint(0, dimension)
        if number_of_starting_points:
            if number:
                return number
            else:
                return random.randint(2, 4)
        return random.randint(1, 3)

    ctl = clingo.Control()
    ctl.configuration.solve.models = solutions_number if solutions_number else 0
    boardl = f"boardl({dimension})."
    starting_points = ""
    model = """#include "asp/model.lp"."""
    for _ in range(casual(number_of_starting_points=True)):
        starting_points += f"number({casual()},{casual()},{casual(turns=True)})."
    ctl.add("base", [], boardl + starting_points + model)
    ctl.ground([("base", [])])
    print(f'\nThe dimension of the board is {dimension}. \n')
    print(f'The starting points are: \n')
    for starting_point in starting_points[:-1].split('.'):
        print(f'{starting_point} \n')
    if "UNSAT" in str(ctl.solve(on_model=asp_prettier)):
        print("No solution found. \n")
