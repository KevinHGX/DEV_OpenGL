#ifndef UIMANAGER_HPP_
#define UIMANAGER_HPP_

#pragma once

#ifdef __cplusplus
extern "C" {
#endif

	#include "SDL.h"

#ifdef __cplusplus
}
#endif

//IMGUI
#include "imgui.h"
#include "imgui_impl_sdl.h"
#include "imgui_impl_sdlrenderer.h"
//IMPLOT
//#include "implot.h"
//#include "implot_internal.h"

class UIManager{
public:
	UIManager(){}
	~UIManager(){}

	inline void SetUp(SDL_Window* _window,SDL_Renderer* _renderer){
		ImGui_ImplSDL2_InitForSDLRenderer(_window,_renderer);
    	ImGui_ImplSDLRenderer_Init(_renderer);
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

	//inline void TestCaseImPlot(){
	//	ImPlot::ShowDemoWindow(true);
	//}

	inline void UpdateNewFrame(){
   		ImGui_ImplSDLRenderer_NewFrame();
    	ImGui_ImplSDL2_NewFrame();
    	ImGui::NewFrame();
	}

	inline void Render(){
		ImGui::Render();
	    ImGui_ImplSDLRenderer_RenderDrawData(ImGui::GetDrawData());
	}

private:
	bool show_demo_window = true;

};

#endif