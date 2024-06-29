CXX := clang++
SUB_INC_DIR   := ./inc
SUB_LIB_DIR   := ./lib
SUB_BUILD_DIR := ./build

SUB_CXXFLAGS  := -ggdb -O2 -Wall -Wextra $(addprefix -I,$(SUB_INC_DIR)) 

STATIC_LIBRARY := $(SUB_LIB_DIR)/libpugXml.a

COMPILE.cc = ${CXX} $(SUB_CXXFLAGS) -c $< -o $@

SUB_LIB_LIST  := $(wildcard $(SUB_LIB_DIR)/*.cpp) 
SUB_LIB_OBJ  :=  $(addprefix $(SUB_BUILD_DIR)/,$(notdir $(SUB_LIB_LIST:.cpp=.o))) 

.PHONY: sub_all 

sub_all: $(STATIC_LIBRARY)

$(SUB_BUILD_DIR)/%.o: ${SUB_LIB_DIR}/%.cpp
	@echo "+++++ Target $@ fired with deps $^..."
	${PRECOMPILE}
	${COMPILE.cc}
	${POSTCOMPILE}

$(STATIC_LIBRARY): $(SUB_LIB_OBJ)
	ar rcs $@ $(SUB_LIB_OBJ)

#....................................................




