"""
Everything related to MiniZinc is contained in this file.
"""
from minizinc import Instance, Solver, Model
from datetime import timedelta


def minizinc_manual(solutions_number):
    model = Model("./minizinc/model.mzn")
    model.add_file("./minizinc/data/input.dzn")
    gecode = Solver.lookup("gecode")
    instance = Instance(gecode, model)
    if solutions_number:
        result = instance.solve(nr_solutions=solutions_number, timeout=timedelta(seconds=300))
    else:
        result = instance.solve(all_solutions=True, timeout=timedelta(seconds=300))
    print(result)
