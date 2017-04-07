#include "wiringPi.h"
#include "wiringSerial.h"
#include "iostream"
using namespace std;

int fd;
int UARTInit()
{	
	wiringPiSetup();
	fd = serialOpen("/dev/serial0",115200);
	return fd;
}

int UARTPrintf()
{
	serialPrintf(fd,"data:");
}


int main()
{
	UARTInit();
	UARTPrintf();
}