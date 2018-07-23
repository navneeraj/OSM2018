#include <iostream>
#include <random>
#include <stdlib.h>
using namespace std;

int main() {
    double iter[ ] = {1e2, 1e3, 1e4};
    for (int i = 0; i < (sizeof(iter)/sizeof(iter[0])); i++) {
        int in_c = 0;
        for (int j =0; j < iter[i]; j++) {
            double x = double(rand())/static_cast<double>(RAND_MAX)-1;
            double y = double(rand())/static_cast<double>(RAND_MAX)-1;
            if (x * x + y * y <= 1) in_c ++;
            }
        double pi = double(in_c)/double(iter[i]);
        cout << "Pi estimated using" << iter[i] << "is " << 4.0 * double(pi) << endl;
    }
 }
