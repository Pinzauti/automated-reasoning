"""
Everything related to MiniZinc (e.g. generate random instances etc.) is contained in this file.
"""
import random
from datetime import timedelta

from minizinc import Instance, Solver, Model


def minizinc_manual(solutions_number):
    """
    Manual instances for MiniZinc. You can modify the input file located in minizinc/data/input.dzn.
    :param solutions_number: choose if you want to see all solutions or just the first one.
    :return: None.
    """
    model = Model("./minizinc/model.mzn")
    model.add_file("./minizinc/data/input.dzn")
    gecode = Solver.lookup("gecode")
    instance = Instance(gecode, model)
    if solutions_number:
        result = instance.solve(nr_solutions=solutions_number, timeout=timedelta(seconds=300))
    else:
        result = instance.solve(all_solutions=True, timeout=timedelta(seconds=300))
    print(result)


def minizinc_random(dimension, number, solutions_number):
    """
    Random instances for MiniZinc. A random instance is generated and printed in a human-readable way. It includes the
    dimension of the board, the number of starting points, the position of the points and the turns they have to make.
    For obvious reasons not all instances will have a solution.
    :param number: the number of starting points defined by the user, used in random mode.
    :param dimension: the dimension of the board defined by the user, used in random mode.
    :param solutions_number: choose if you want to see all solutions or just the first one.
    :return: None.
    """
    model = Model("./minizinc/model.mzn")
    gecode = Solver.lookup("gecode")
    instance = Instance(gecode, model)
    instance["dimension"] = dimension if dimension else random.randint(3, 5)
    instance["number"] = number if number else random.randint(2, 5)
    instance["starting_points"] = [
        [random.randint(1, dimension), random.randint(1, dimension), random.randint(0, dimension)] for _ in
        range(number)]

    print(f'\nThe dimension of the board is {dimension}. \n')
    print(f'The starting points are: \n')
    for point in instance["starting_points"]:
        print(f'Coordinates: ({point[0]}, {point[1]}) with turns: {point[2]}')

    if solutions_number:
        result = instance.solve(nr_solutions=solutions_number, timeout=timedelta(seconds=300))
    else:
        result = instance.solve(all_solutions=True, timeout=timedelta(seconds=300))
    print(result)
