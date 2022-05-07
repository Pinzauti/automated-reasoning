"""
entrypoint
"""
import argparse
import clingo
import re


def on_model(m):
    """
    Prints the APS result in a prettier and more comprehensible way.
    :param m: the model.
    """
    goal_point = re.match(r'goal\(\d,\d\)', str(m))
    links = re.findall(r'link\(start\(\d,\d\),end\(\d,\d\)\)', str(m))

    if goal_point:
        print("The intersecion point is: ") 
        print(goal_point.group() + "\n")
     
    if links:
        print("The links to get to the intersection points are the following: \n")
        for link in links:
            print(link + '\n')


def asp_manual():
    """
    Manual input for ASP. You can modify the input file located in asp/data/input.lp.
    """
    ctl = clingo.Control()
    ctl.add("base", [], """\
        #include "asp/data/input.lp". 
        #include "asp/main.lp". 
        """)
    ctl.ground([("base", [])])
    ctl.solve(on_model=on_model)

def main(tool, mode):
    """
    Entrypoint of the program.
    :param tool: the tool to use, either ASP or MiniZinc.
    :param mode: if the input is manual or random.
    """

    if tool == "asp":
        if mode == "manual":
            asp_manual()


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