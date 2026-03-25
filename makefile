NVCC = nvcc

TARGET = nbody

SRCS = cpu_simulation.cu kernel.cu main.cu

NVCC_FLAGS = -O2

all : $(TARGET) 

$(TARGET) : $(SRCS) 
	$(NVCC) $(NVCC_FLAGS) $(SRCS) -o $(TARGET)

run : $(TARGET)
	./$(TARGET)

clean : 
	rm -f $(TARGET)