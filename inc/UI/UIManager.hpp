#ifndef UIMANAGER_HPP_
#define UIMANAGER_HPP_

#pragma once

#ifdef __cplusplus
extern "C" {
#endif

	#include "SDL.h"
	#include "glad.h"

#ifdef __cplusplus
}
#endif

//IMGUI
#include "imgui.h"
#include "imgui_impl_sdl.h"
#include "imgui_impl_opengl3.h"

class UIManager{
public:
	UIManager(){}
	~UIManager(){}

	inline void SetUp(SDL_Window* _window,SDL_GLContext _context){
    	ImGui_ImplSDL2_InitForOpenGL(_window, _context);
    	ImGui_ImplOpenGL3_Init("#version 330");
	}

	static inline void InputEvent(const SDL_Event& _event){	
		ImGui_ImplSDL2_ProcessEvent(&_event);
	}

	inline void TestCaseImGui(){
		if (show_demo_window){
            ImGui::ShowDemoWindow(&show_demo_window);
            ImGui::ShowUserGuide();
        }
	}

	inline void UpdateNewFrame(){
		ImGui_ImplOpenGL3_NewFrame();
    	ImGui_ImplSDL2_NewFrame();
    	ImGui::NewFrame();
	}

	inline void Render(){
		ImGui::Render();
    	ImGui_ImplOpenGL3_RenderDrawData(ImGui::GetDrawData());
	}

private:
	bool show_demo_window = true;

};

#endif