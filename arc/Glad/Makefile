CXX := clang
SUB_INC_DIR := ./inc 
INC_HEADER := $(SUB_INC_DIR)/glad
SUB_SRC_DIR := ./src
SUB_LIB_DIR := ./lib
SUB_BUILD_DIR := ./build

SUB_CXXFLAGS := -ggdb -Wall -Wextra $(addprefix -I,$(INC_HEADER)) 

STATIC_LIBRARY := $(SUB_LIB_DIR)/libGlad.a

COMPILE.cc = ${CXX} $(SUB_CXXFLAGS) -c $< -o $@

SUB_SRC_LIST  := $(wildcard $(SUB_SRC_DIR)/*.c) 
SUB_LIB_OBJ  :=  $(addprefix $(SUB_BUILD_DIR)/,$(notdir $(SUB_SRC_LIST:.c=.o))) 

.PHONY: sub_all 

sub_all: $(STATIC_LIBRARY)

$(SUB_BUILD_DIR)/%.o: ${SUB_SRC_DIR}/%.c
	@echo "+++++ Target $@ fired with deps $^..."
	${PRECOMPILE}
	${COMPILE.cc}
	${POSTCOMPILE}

$(STATIC_LIBRARY): $(SUB_LIB_OBJ)
	ar rcs $@ $(SUB_LIB_OBJ)

#....................................................
