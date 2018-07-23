all: hello_kns.exec solve_quadratic.exec cal_pi.exec montecarlo.exec

#######################################################################

## Hello Program
hello_kns.exec : hello_kns.CPP
	g++ hello_kns.CPP -fopenmp -o hello_kns.exec
#######################################################################

#######################################################################

## Quadratic_Solver
solve_quadratic.exec : solve_quadratic.cpp
	g++ solve_quadratic.cpp -fopenmp -o solve_quadratic.exec
#######################################################################
#######################################################################

## Pi_Solver
cal_pi.exec : cal_pi.cpp
	g++ cal_pi.cpp -fopenmp -o cal_pi.exec
#######################################################################
#######################################################################

## montecarlo simulation for pi
montecarlo.exec : montecarlo.cpp
	g++ montecarlo.cpp -fopenmp -o montecarlo.exec
#######################################################################
#######################################################################

clean :
	rm -f *.exec

#######################################################################
