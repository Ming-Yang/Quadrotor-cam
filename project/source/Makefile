CC = g++  
DLIBS = -lopencv_core -lopencv_imgproc -lopencv_highgui -lopencv_calib3d -lwiringPi -lpthread
OBJS = main.o gpio.o image.o 

pi-check : $(OBJS)
	$(CC) $(OBJS) $(DLIBS) -o pi-check
	
main : main.cpp
	$(CC) -c main.cpp $(DLIBS)  

image : image.cpp
	$(CC) -c image.cpp $(DLIBS)  

gpio : gpio.cpp 
	$(CC) -c gpio.cpp $(DLIBS)  

clean:
	rm -rf *.o
