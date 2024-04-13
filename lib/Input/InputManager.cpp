#include "../../inc/Input/InputManager.hpp"

void InputManager::ProcessEventKeyBoard(SDL_Event& _event) {
	if(_event.type == SDL_KEYDOWN){
		switch(_event.key.keysym.sym){
			case SDLK_UP:

				break;
			case SDLK_DOWN:

				break;
			case SDLK_RIGHT:

				break;
			case SDLK_LEFT:

				break;
		}
	}		
}