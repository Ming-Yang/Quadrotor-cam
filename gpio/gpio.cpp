#include "gpio.h"
using namespace std;

int fd;
int UARTInit()
{	
	wiringPiSetup();
	fd = serialOpen("/dev/serial0",115200);
	cout<<"fd="<<fd<<endl;
	return fd;
}

int UARTPrintf()
{
	serialPrintf(fd,"data:");
}


