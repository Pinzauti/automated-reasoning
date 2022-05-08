HELP = python3 main.py -h
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
MINIZINC = ${PYTHON} main.py minizinc

default:
	@echo Hello there, if you need any help just write make help.
	@echo I would start with the project setup, to do that just write make setup.

setup:
	python3 -m venv $(VENV)
	${PIP} install --upgrade pip
	${PIP} install -r requirements.txt

help:
	${HELP}

asp-manual:
	@${ASP-MANUAL} $(if $(s),-s=$(s))

asp-random:
	@${ASP-RANDOM} $(if $(d),-d=$(d)) $(if $(n),-n=$(n)) $(if $(s),-s=$(s))
minizinc:
	@${MINIZINC}
