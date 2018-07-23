#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <omp.h>
#include <iostream>


int main()
{
    double niter = 10000000;
    double x,y;
    int i;
    int count=0;
    double z;
    double pi;
    //srand(time(NULL));
    //main loop
    double time_serial = -omp_get_wtime();
    for (i=0; i<niter; ++i)
    {
        //get random points
        x = (double)random()/RAND_MAX;
        y = (double)random()/RAND_MAX;
        z = sqrt((x*x)+(y*y));
        //check to see if point is in unit circle
        if (z<=1)
        {
            ++count;
        }
    }
    pi = 4.0* (double)count/(double)niter;
    time_serial += omp_get_wtime();

    std::cout << niter
              << " steps approximates pi as : "
              << pi;
    std::cout << "   the solution took " << time_serial << " seconds" <<std::endl;
}
