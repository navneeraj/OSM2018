/*======================================================================   
 * 
 *     example program to demonstrate Bcast
 * 
 * ======================================================================*/   

    #include <stdio.h>
    #include <iostream>
    #include "mpi.h"

    using namespace std;

    int main(int argc, char *argv[]) {
    int rank;
    MPI_Init(&argc, &argv);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    
    int root_process = 3;
    double data = 0.0;
    if (rank==0){
      data =5.0;
    }
    else{
      data = 7.8;
    }
      

    /* broadcast the value of data of rank 0 to all ranks */
    MPI_Bcast(&data, 1, MPI_DOUBLE, root_process, MPI_COMM_WORLD);

    cout << "I am rank " << rank << " and the value is " <<  data << endl;
    MPI_Finalize();
    return 0;
}
