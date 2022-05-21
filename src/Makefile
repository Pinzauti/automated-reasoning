VENV = env

ifeq ($(OS), Windows_NT)
	PIP = .\$(VENV)\Scripts\pip.exe
	PYTHON = .\$(VENV)\Scripts\python.exe
else
	PIP = ./$(VENV)/bin/pip
	PYTHON = ./$(VENV)/bin/python
endif

ASP-MANUAL = ${PYTHON} main.py asp manual
ASP-RANDOM = ${PYTHON} main.py asp random
MINIZINC-MANUAL = ${PYTHON} main.py minizinc manual
MINIZINC-RANDOM = ${PYTHON} main.py minizinc random
BOTH = ${PYTHON} main.py both manual
HELP = ${PYTHON} main.py -h

default:
	@echo Hello there, if you need any help just write make help.
	@echo I would start with the project setup, to do that just write make setup.

setup:
	python -m venv $(VENV)
	${PIP} install -r requirements.txt

help:
	${HELP}

asp-manual:
	@${ASP-MANUAL} $(if $(s),-s=$(s))

asp-random:
	@${ASP-RANDOM} $(if $(d),-d=$(d)) $(if $(n),-n=$(n)) $(if $(s),-s=$(s))

minizinc-manual:
	@${MINIZINC-MANUAL} $(if $(s),-s=$(s))

minizinc-random:
	@${MINIZINC-RANDOM} $(if $(d),-d=$(d)) $(if $(n),-n=$(n)) $(if $(s),-s=$(s))

both:
	@${BOTH} $(if $(s),-s=$(s))
