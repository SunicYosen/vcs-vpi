#include <iostream>
#include <vpi_user.h>

using namespace std;

void printHello();

extern "C" void helloVPICPP()
{
    cout << "Hello world !\n" << endl;
    //printHello();
    return;
}

void printHello()
{
    cout << "hello!\n" << endl;
    return;
}