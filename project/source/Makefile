CC = g++  
DLIBS = -lopencv_core -lopencv_imgproc -lopencv_highgui -lopencv_calib3d -lwiringPi -lpthread
OBJS = main.o gpio.o image.o 

pi-check : main.cpp $(OBJS)
	$(CC) main.c $(OBJS) -o pi-check
	
image.o : image.cpp
	$(CC) -c image.cpp $(DLIBS)  

gpio.o : gpio.cpp 
	$(CC) -c gpio.cpp $(DLIBS)  

clean:
	rm -rf *.o
