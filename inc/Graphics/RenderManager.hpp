#ifndef RenderManager_HPP_
#define RenderManager_HPP_

#pragma once

#include <iostream>
#include <string>

/*============================
=            SDL2            =
============================*/

#ifdef __cplusplus
extern "C" {
#endif
	//SDL
	#include "SDL.h" //window
	#include "SDL_image.h" //icons
	#include "SDL_video.h"
	//GLAD
	#include "glad.h"
#ifdef __cplusplus
}
#endif

/*=====  End of SDL2  ======*/

/*=============================================
=                Own Headers                  = 
=============================================*/

#include "../Config/Complements.hpp"

/*=========   End of Own Headers   ==========*/

/*=======================================
=            CONAN'S LIBRARY            =
=======================================*/

#include "pugixml.hpp"

/*=====  End of CONAN'S LIBRARY  ======*/

/*----------  Class principal  ----------*/

class RenderManager{
public:
	static RenderManager& getInstance(){
		static RenderManager instance;
		return instance;
	}

public:
	RenderManager(){}
	RenderManager(const RenderManager&)=delete;
	RenderManager& operator=(const RenderManager&)=delete;
	~RenderManager(){
		Cleanup();
	}

	void initSettingXMLWindow();
	void SetUpWindow();
	void Cleanup();

	inline SDL_Window* getWindow() const {
		return this->window;
	}

	inline int getScreenWidth() const {
		return this->SCREEN_WIDTH;
	}

	inline int getScreenHeight() const {
		return this->SCREEN_HEIGHT;
	}

	inline SDL_GLContext getContext() const{
		return this->context;
	}

	inline void SetGL(){
		glClearColor(0,0,0,1);
    	glClear(GL_COLOR_BUFFER_BIT);
    	SDL_GL_SwapWindow(this->window);
	}


private:
	SDL_Window* window{NULL};
	//OpenGl
	SDL_GLContext context;

public:
	
	std::string Title = "";
	std::string ICON = "";
	int SCREEN_WIDTH;
	int SCREEN_HEIGHT;

};


#endif
