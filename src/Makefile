HELP = python3 main.py -h
ASP-MANUAL = python3 main.py asp manual
ASP-RANDOM = python3 main.py asp random
MINIZINC = python3 main.py minizinc

VENV = env

default:
	@echo Hello there, if you need any help just write make help.
	@echo I would start with the project setup, to do that just write make setup.

setup:
	python3 -m venv $(VENV)
ifeq ($(OS), Windows_NT)
	.\$(VENV)\Scripts\pip.exe install --upgrade pip
	.\$(VENV)\Scripts\pip.exe install -r requirements.txt
else
	$(VENV)/bin/pip install --upgrade pip
	$(VENV)/bin/pip install -r requirements.txt
endif

help:
	${HELP}

asp-manual:
	@${ASP-MANUAL} $(if $(-n),-n=$(n))

asp-random:
	${ASP-RANDOM} $(if $(d),-d=$(d)) $(if $(n),-n=$(n)) $(if $(a),-a=$(a))
minizinc:
	@${MINIZINC}
