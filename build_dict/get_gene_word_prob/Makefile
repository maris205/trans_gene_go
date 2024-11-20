#SRIPATH is the srilm path you install,please set it first
SRIPATH=/data4/mariswang/srilm/

#please set your own MACHINE_TYPE, same as your set in installing srilm
MACHINE_TYPE=i686-m64

CXX=g++
CXXFLAGS=-O3 -I$(SRIPATH)/include

vpath lib%.a $(SRIPATH)/lib/$(MACHINE_TYPE)

TARGET=get_prob
SRC = get_prob.cpp
OBJ = $(SRC:.cpp=.o)

.PHONY: all clean

all: $(TARGET)

$(TARGET): $(OBJ) -loolm -ldstruct -lmisc
	$(CXX) $(LDFLAGS) -o $@ $^
	cp $(TARGET) ../

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $<

clean:
	$(RM) $(OBJ) $(TARGET)

