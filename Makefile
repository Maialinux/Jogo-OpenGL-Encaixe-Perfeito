# Makefile para o jogo Encaixe Perfeito (Linux OpenGL / FreeGLUT)

CXX ?= g++
CXXFLAGS ?= -Wall -Wextra -O2 -std=c++11 -I.
LDFLAGS ?=
LIBS = -lglut -lGLU -lGL -lm

TARGET = Tank
SRC = main.cpp
OBJ = $(SRC:.cpp=.o)

all: check_deps $(TARGET)

check_deps:
	@which $(CXX) > /dev/null 2>&1 || (echo "Erro: Compilador $(CXX) não encontrado." && exit 1)
	@echo "#include <GL/glut.h>" | $(CXX) -E -x c++ - > /dev/null 2>&1 || { \
		echo "==========================================================="; \
		echo "AVISO: Dependências OpenGL/GLUT não encontradas!"; \
		echo "No Debian/Ubuntu/Mint execute:"; \
		echo "   sudo apt update && sudo apt install -y freeglut3-dev libglu1-mesa-dev"; \
		echo "No Arch Linux execute:"; \
		echo "   sudo pacman -S freeglut glu mesa"; \
		echo "No Fedora execute:"; \
		echo "   sudo dnf install freeglut-devel mesa-libGLU-devel"; \
		echo "==========================================================="; \
		exit 1; \
	}

$(TARGET): $(OBJ)
	$(CXX) $(CXXFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS)

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

run: all
	./$(TARGET)

clean:
	rm -f $(OBJ) $(TARGET) bin/Debug/Tank bin/Release/Tank obj/Debug/*.o obj/Release/*.o

.PHONY: all run clean check_deps
