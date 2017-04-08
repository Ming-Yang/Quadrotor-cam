#include "../include/gpio.h"
#include "../include/image.h"

using namespace std;
using namespace cv;

int main()
{
	Init();
	while (RectifyCorrespondence());
	cout << ObstacleCheck(5000, 20, 10000, 300) << endl;

	UARTPrintf();
	cout << "ok" << endl;

	while (1);
	return 0;
}

void Init()
{
	UARTInit();
	cout << "begin..." << endl;
	while (ReadPara("../../data/para.txt"));
	while (PreImageGet("../../data/R3.jpg", "../../data/L3.jpg"));
	StereoParaCal();

	while (RectifyCorrespondence());
	center = FindCentre();
	cout<<ObstacleCheck(5000, 20, 10000, 300)<<endl;

	cout << "ok" << endl;
}