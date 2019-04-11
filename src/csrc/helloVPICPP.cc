#include <iostream>
#include <vpi_user.h>

using namespace std;

extern "C" void printHello();

int *a=new int[1];

extern "C" void helloVPICPP()
{
    cout << "Hello World! ----cycle_count = " << *a << endl;
    return;
}

extern "C" void printHello()
{
    cout << "hello!\n" << endl;
    return;
}