#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <omp.h>
#include <iostream>
#define _USE_MATH_DEFINES


int main()
{
    const int niter = 1000000000;
    double x,y;
    int count=0;
    double z;
    double pi;
    int thread;
    std::cout << "using " << omp_get_max_threads() << " OpenMP threads" << std::endl;
    double time = -omp_get_wtime();

    #pragma omp parallel for reduction(+:count)
    for (int i=0; i<niter; ++i)
    {
        //get random points
        x = (double)random()/RAND_MAX;
        y = (double)random()/RAND_MAX;
        z = sqrt((x*x)+(y*y));
        //check to see if point is in unit circle
        if (z<=1)
        {
            count += 1;
        }
    }
    time += omp_get_wtime();

    pi = 4.0* (double)count/(double)niter;       //p = 4(m/n)
    //printf("Pi: %f\n", pi);

    std::cout << niter
              << " steps approximates pi as : "
              << pi;
    std::cout << "  the solution took " << time << "   seconds" <<std::endl;
    return 0;
}
