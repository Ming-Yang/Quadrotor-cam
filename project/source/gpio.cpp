#include "../includes/gpio.h"
using namespace std;

int fd;
int UARTInit()
{	
	wiringPiSetup();
	fd = serialOpen("/dev/serial0",115200);
	serialPrintf(fd,"\nInitOK\n");
	return fd;
}

void UARTPrintf()
{
	serialPrintf(fd,"data:");
}


