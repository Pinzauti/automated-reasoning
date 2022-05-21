"""
Everything related to MiniZinc (e.g. generate random instances etc.) is contained in this file.
"""
from minizinc import Instance, Solver, Model
import random
from datetime import timedelta


def minizinc_prettier(result):
    if result:
        for sol in result.solution:
            print('A possible solution is: \n')
            for i in sol.Board:
                for element in i:
                    print(f'{element[0]}', end=' ')
                print('\n')
    else:
        print("No solution found. \n")


def minizinc_manual(solutions_number):
    """
    Manual instances for MiniZinc. You can modify the input file located in minizinc/data/input.dzn.
    :param solutions_number: choose if you want to see all solutions or just the first one.
    :return: None.
    """
    model = Model("./minizinc/model.mzn")
    model.add_file("./minizinc/data/input.dzn")
    gecode = Solver.lookup("chuffed")
    instance = Instance(gecode, model)
    if solutions_number:
        result = instance.solve(nr_solutions=solutions_number, timeout=timedelta(seconds=300))
    else:
        result = instance.solve(all_solutions=True, timeout=timedelta(seconds=300))
    minizinc_prettier(result)


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
    gecode = Solver.lookup("chuffed")
    instance = Instance(gecode, model)
    instance["dimension"] = dimension if dimension else random.randint(3, 5)
    instance["number"] = number if number else random.randint(2, 4)
    instance["starting_points"] = [[random.randint(1, instance["dimension"]), random.randint(1, instance["dimension"]),
                                    random.randint(0, instance["dimension"])] for _ in range(instance["number"])]

    print(f'\nThe dimension of the board is {instance["dimension"]}. \n')
    print(f'The starting points are: \n')
    for point in instance["starting_points"]:
        print(f'Coordinates: ({point[0]}, {point[1]}) with turns: {point[2]}')

    if solutions_number:
        result = instance.solve(nr_solutions=solutions_number, timeout=timedelta(seconds=300))
    else:
        result = instance.solve(all_solutions=True, timeout=timedelta(seconds=300))
    minizinc_prettier(result)
