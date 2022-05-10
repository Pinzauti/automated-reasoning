from minizinc import Instance, Model, Solver


def minizinc_manual():
    model = Model("./minizinc/model.mzn")
    model.add_file("./minizinc/data/input.dzn")
    gecode = Solver.lookup("gecode")
    instance = Instance(gecode, model)
    result = instance.solve()
    print(result["q"])
