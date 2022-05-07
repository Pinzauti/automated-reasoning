"""
entrypoint
"""
import argparse
import re
import clingo


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


def clingo_manual():
    """

    """
    ctl = clingo.Control()
    ctl.add("base", [], """ #include "asp/main.lp". """)
    ctl.ground([("base", [])])
    ctl.solve(on_model=on_model)

def main(tool, mode):
    """
    Main function.
    :param tool: 
    :param mode: 
    """

    if tool == "asp":
        if mode == "manual":
            clingo_manual()


def init():
    """
    It collects the arguments to pass to the main function, which is then called.
    :return: None.
    """
    parser = argparse.ArgumentParser(description="Start the project.")
    parser.add_argument("--tool",
                        choices=["asp", "minizinc"],
                        help="Choose between ASP and MiniZinc.")
    parser.add_argument("--mode",
                        choices=["manual", "random"],
                        help="Choose if the input is manual or random.")
    main(
        tool=parser.parse_args().tool,
        mode=parser.parse_args().mode
        )

init()