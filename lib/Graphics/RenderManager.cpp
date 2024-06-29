#include "../inc/Graphics/RenderManager.hpp"
#include "../inc/Config/Exception.hpp"
#include "../inc/Util/MemoryCleanup.hpp"

void RenderManager::initSettingXMLWindow() {
    
    pugi::xml_document doc;

    if(!doc.load_file("../inc/Config/SettingXML/window.xml")){
        throw Exception(__FILE__,"ERROR: No puede leer el archivo XML",__LINE__);
    }

    // Accediendo a los nodos y atributos
    this->Title = doc.child("configuracion").child("title").text().as_string();
    this->ICON = doc.child("configuracion").child("icon").text().as_string();

    pugi::xml_node window = doc.child("configuracion").child("window");

    this->SCREEN_WIDTH = window.child("sizeWidth").text().as_int();
    this->SCREEN_HEIGHT = window.child("sizeHeight").text().as_int();

}

void RenderManager::SetUpWindow(){

    initSettingXMLWindow();   

    SDL_GL_SetAttribute(SDL_GL_CONTEXT_FLAGS, SDL_GL_CONTEXT_FORWARD_COMPATIBLE_FLAG);
    SDL_GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK, SDL_GL_CONTEXT_PROFILE_CORE);
    SDL_GL_SetAttribute(SDL_GL_CONTEXT_MAJOR_VERSION, 3);
    SDL_GL_SetAttribute(SDL_GL_CONTEXT_MINOR_VERSION, 3);
    SDL_GL_SetAttribute(SDL_GL_DOUBLEBUFFER, 1);
    SDL_GL_SetAttribute(SDL_GL_DEPTH_SIZE, 24);
    SDL_GL_SetAttribute(SDL_GL_STENCIL_SIZE, 8);

	SDL_WindowFlags window_flags = (SDL_WindowFlags)(SDL_WINDOW_OPENGL | SDL_WINDOW_RESIZABLE | SDL_WINDOW_ALLOW_HIGHDPI);
    this->window = SDL_CreateWindow(this->Title.c_str(), SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED, this->SCREEN_WIDTH, this->SCREEN_HEIGHT, window_flags);
    ASSERT(window,__FILE__,__LINE__);

    this->context = SDL_GL_CreateContext(window); 
    ASSERT(context,__FILE__,__LINE__);
    SDL_GL_MakeCurrent(window, context);
    SDL_GL_SetSwapInterval(1);

    if(!gladLoadGLLoader((GLADloadproc)SDL_GL_GetProcAddress)){
        throw Exception(__FILE__,"No se han cargado las funciones de OpenGL",__LINE__);
    }

    SDL_Surface* icon = IMG_Load(COMPLEMENTS::DEFAULT.c_str());
    ASSERT(icon,__FILE__,__LINE__);

    SDL_SetWindowIcon(window,icon);  
    MemoryCleanUp(icon);
}

void RenderManager::Cleanup(){
	/*----------  SDL2  ----------*/
    SDL_GL_DeleteContext(context);
	MemoryCleanUp(window);
}