#MACROS
CXX       := clang++

#------------ ABOUT PROJECT -----------------------

BIN_DIR   := ./bin
ARC_DIR   := ./arc
INC_DIR   := ./inc
LIB_DIR   := ./lib
SRC_DIR   := ./src
BUILD_DIR := ./build

CORE_DIR  := $(LIB_DIR)/Core
GRAP_DIR  := $(LIB_DIR)/Graphics
INPU_DIR  := $(LIB_DIR)/Input
UI_DIR    := $(LIB_DIR)/UI

# --------- CONAN´S PACKAGE -----------------------

#Agregando dependencias "conandeps.mk"
CONAN_GENERATOR_FOLDER = $(ARC_DIR)/build

.PHONY: Version
Version:
	@echo ">> $(CONAN_REFERENCE_SDL) +"
	@echo ">> $(CONAN_REFERENCE_SDL_IMAGE) +"

.PHONY: Conan_Install
Conan_Install:
	@echo ">> Instalando dependencias y generado/actualizado (generators)"
	conan install . --build=missing -of $(CONAN_GENERATOR_FOLDER)

.PHONY: Conan_Remove
Conan_Remove:
	@echo "Removiendo todos los paquetes"
	conan remove "*"

include $(CONAN_GENERATOR_FOLDER)/build/generators/conandeps.mk #incluir Makefile de Conan

#----------  Headeres Library only HPP CONAN  ----------

EIGEN_SRC := $(CONAN_INCLUDE_DIRS_EIGEN)/
#INC_HEADERS_EIGEN = $(shell find "$(EIGEN_SRC)" -type f -name '*.h')

INC_ALL_LIBRARY_HPP =$(addprefix -I,$(CONAN_INCLUDE_DIRS_PUGIXML)) -I $(EIGEN_SRC)
INC_ALL_LIBRARY_HPP +=  $(addprefix -I,$(DIR_INC_IMGUI)) 
INC_ALL_LIBRARY_HPP += $(addprefix -I,$(DIR_INC_XML)) 
INC_ALL_LIBRARY_HPP += $(addprefix -I,$(DIR_INC_GLAD))

#---------------------- SDL2 -----------------------------------
LIBS = 	-L"./arc/SDL2/SDL2-devel-2.28.3-mingw/SDL2-2.28.3/x86_64-w64-mingw32/lib" \
		-L"./arc/SDL2/SDL2_image-devel-2.0.5-mingw/SDL2_image-2.0.5/x86_64-w64-mingw32/lib" -static-libgcc -lmingw32 -lSDL2main -lSDL2 -lSDL2_test -lSDL2_image

INC_SDL := 	-I"./arc/SDL2/SDL2-devel-2.28.3-mingw/SDL2-2.28.3/x86_64-w64-mingw32/include/SDL2" \
		-I"./arc/SDL2/SDL2_image-devel-2.0.5-mingw/SDL2_image-2.0.5/x86_64-w64-mingw32/include/SDL2"

#---------------------- CXXFLAGS ----------------------------------
DEPFLAGS  := -MP -MD

CXXFLAGS  = -ggdb 
CXXFLAGS += -O2 
CXXFLAGS += -Wall 
CXXFLAGS += $(addprefix -I,$(INC_DIR)) 
CXXFLAGS += $(DEPFLAGS) $(INC_SDL)  
#CXXFLAGS += $(addprefix -I,$(DIR_INC_PLOT))
CXXFLAGS += $(INC_ALL_LIBRARY_HPP)

#------------------ SUBMAKE AND DEFINE STATIC-LIBRARY IMGUI -----------
IMGUI := ./arc/ImGui
DIR_INC_IMGUI 	:= $(IMGUI)/inc
DIR_LIB_IMGUI 	:= $(IMGUI)/lib
DIR_BUILD_IMGUI 	:= $(IMGUI)/build

STATIC_LIBRARY_IMGUI = $(DIR_LIB_IMGUI)/libm_biblioteca.a

#LIB_LIST_IMGUI = $(wildcard $(DIR_LIB_IMGUI)/*.cpp) 
#LIB_OBJ_IMGUI = $(wildcard $(DIR_BUILD_IMGUI)/*.o) 

.PHONY: sub_make_ImGui
sub_make_ImGui: 
	@echo ">>>> CREATE STATIC LIBRARY IMGUI <<<<"
	$(MAKE) -C $(IMGUI)

#------------------ SUBMAKE AND DEFINE STATIC LLIBRARRY GLAD -------------------
GLAD := ./arc/Glad
DIR_INC_GLAD 		:= $(GLAD)/inc/glad
DIR_LIB_GLAD 		:= $(GLAD)/lib
DIR_BUILD_GLAD 	:= $(GLAD)/build
STATIC_LIBRARY_GLAD 	:= $(DIR_LIB_GLAD)/libGlad.a


.PHONY: sub_make_Glad
sub_make_Glad:
	@echo ">>>> CREATE STATIC LIBRARY GLAD <<<<"
	$(MAKE) -C $(GLAD)


#------------------ SUBMAKE AND DEFINE STATIC LIBRARY XML ----------------------
XML := ./arc/PugXML
DIR_INC_XML 		:= $(XML)/inc
DIR_LIB_XML 		:= $(XML)/lib
DIR_BUILD_XML 	:= $(XML)/build
STATIC_LIBRARY_XML 	:= $(DIR_LIB_XML)/libpugXml.a

.PHONY:sub_make_XML
sub_make_XML:
	@echo ">>>> CREATE STATIC LIBRARY XML <<<<"
	$(MAKE) -C $(XML)

#---------------------- ImPlot -------------------------------------
#DIR_INC_PLOT = $(CONAN_INCLUDE_DIRS_IMPLOT)
#DIR_LIB_PLOT = -L $(CONAN_LIB_DIRS_IMPLOT) -limplot

#---------------------- PROJECT -----------------------------------
#Todos los Archivos Cpp
ALL_LIST_CPP = $(wildcard $(SRC_DIR)/*.cpp) $(wildcard $(LIB_DIR)/**/*.cpp) 

#Archivos Cpp (/lib y /src)
SRC_LIST  = $(wildcard $(SRC_DIR)/*.cpp) 
LIB_LIST  = $(wildcard $(LIB_DIR)/**/*.cpp) 

#Dependencias
DEP_LIST = $(addprefix $(BUILD_DIR)/,$(notdir $(ALL_LIST_CPP:.cpp=.d))) 

#Objetos
SRC_OBJ =  $(addprefix $(BUILD_DIR)/,$(notdir $(SRC_LIST:.cpp=.o))) 
LIB_OBJ =  $(addprefix $(BUILD_DIR)/,$(notdir $(LIB_LIST:.cpp=.o))) 
#LIB_OBJ += $(wildcard $(DIR_BUILD_GLAD)/*.o)

#--------------------- END PROJECT --------------------------------

#--------------- GENERATE .OBJ'S TO PROJECT -----------------------
#SRC
$(SRC_OBJ): $(SRC_LIST) #Main.cpp
	@echo "+++++ Target $@ fired with deps $^..."
	$(CXX) $(CXXFLAGS) -c $< -o $@  

#LIB
COMPILE.cc = ${CXX} $(CXXFLAGS) -c $< -o $@

#CORE
${BUILD_DIR}/%.o: ${CORE_DIR}/%.cpp 
	@echo "+++++ Target $@ fired with deps $^..."
	${PRECOMPILE}
	${COMPILE.cc}
	${POSTCOMPILE}
#GRAPHICS
${BUILD_DIR}/%.o: ${GRAP_DIR}/%.cpp 
	@echo "+++++ Target $@ fired with deps $^..."
	${PRECOMPILE}
	${COMPILE.cc}
	${POSTCOMPILE}
#INPUT
${BUILD_DIR}/%.o: ${INPU_DIR}/%.cpp 
	@echo "+++++ Target $@ fired with deps $^..."
	${PRECOMPILE}
	${COMPILE.cc}
	${POSTCOMPILE}
#UI
${BUILD_DIR}/%.o: ${UI_DIR}/%.cpp 
	@echo "+++++ Target $@ fired with deps $^..."
	${PRECOMPILE}
	${COMPILE.cc}
	${POSTCOMPILE}
	
#---------------------- OBJETIVES ------------------------------------
.PHONY: build   
build: sub_make_ImGui sub_make_XML sub_make_Glad sub-make-SDL

.PHONY: sub-make-SDL
sub-make-SDL: $(SRC_OBJ) $(LIB_OBJ) 

PROG_NAME = Application
.PHONY: ${PROG_NAME}

.PHONY: bin
bin: $(PROG_NAME) 

#--------------------- CREATE EXECUTIVE --------------------------------
#EXPLICIT RULE
$(PROG_NAME): $(SRC_OBJ) $(LIB_OBJ) $(STATIC_LIBRARY_IMGUI) $(STATIC_LIBRARY_XML)
	@echo ">>> Generating executable $@ <<<"
	$(CXX) $(SRC_OBJ) $(LIB_OBJ) -o $(BIN_DIR)/$@ $(STATIC_LIBRARY_IMGUI) $(STATIC_LIBRARY_GLAD) $(STATIC_LIBRARY_XML) $(LIBS) 

#---------------------- CLEAN PROJECT ----------------------------------
.PHONY: cleanAll
cleanAll:
	rm -f $(BIN_DIR)/$(PROG_NAME) $(BUILD_DIR)/*.o $(BUILD_DIR)/*.d  $(DIR_BUILD_IMGUI)/*.o $(STATIC_LIBRARY_IMGUI) $(DIR_BUILD_XML)/*o $(STATIC_LIBRARY_XML) $(DIR_BUILD_GLAD)/*o $(STATIC_LIBRARY_GLAD)

.PHONY: clean
clean:
	rm -f $(BIN_DIR)/$(PROG_NAME) $(BUILD_DIR)/*.o $(BUILD_DIR)/*.d 

#---------------------------------------------------------
# Let's include dependencies calculated by CC
-include $(DEPFLAGS)

##--------------------FFMPEG------------------------------
CAPTURE := ffmpeg -f gdigrab -framerate 30 -i title="ENGINE" -vcodec libx264 -preset ultrafast -tune zerolatency -b:v 4M -maxrate 4M -bufsize 8M ./res/videos/ENGINE.mp4

.PHONY: G

G:
	@echo ">>> REC..."
	${CAPTURE}

.PHONY: remove

VIDEO := ./res/videos/ENGINE.mp4

remove: 
	rm ${VIDEO}