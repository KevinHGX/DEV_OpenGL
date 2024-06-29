#include "../inc/Core/Application.hpp"
#include "../inc/Config/Exception.hpp"

void Application::StartUp(){
	ConfWindow->SetUpWindow();
	ConfWindow->SetGL();
    UI->SetUp(ConfWindow->getWindow(),ConfWindow->getContext());
    //time.fpsTimer.start();
	//time.capTimer.start();
}

void Application::Execute(){
	while(!this->statusApplication){
		
		Events();
		Update();
		Clear();
		Render();

		//this->time.Delay();
		//SDL_Delay(50);
    }
}

/*----------  Private Functions  ----------*/

void Application::Events(){
	SDL_PollEvent(&(event));
	Input->WindowEvent(statusApplication,event,ConfWindow->getWindow());//Window
	Input->ProcessEventKeyBoard(event);//KeyBoard
	Input->ProcessEvent(event);//Imgui
}

void Application::Update() {
	UI->UpdateNewFrame();
	UI->TestCaseImGui();
	//this->time.capTimer.start();
	//this->time.Update();
}

void Application::Clear() {
	glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
	glClear(GL_COLOR_BUFFER_BIT);
}

void Application::Render() {	

	UI->Render();
		

	SDL_GL_SwapWindow(ConfWindow->getWindow());
}