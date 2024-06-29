#include "../inc/Core/Application.hpp"
#include "../inc/Config/General.hpp"

int main(int, char**) {//SDL Main

    InitImGUI();

    try {

        InitSDL();
        SetAttributeGL();

        Application::getInstance().StartUp();
        Application::getInstance().Execute();

    } catch (const Exception &ex) {

        std::cerr << "Error: " << ex.what() << std::endl;
        CloseSDL();
        CloseImGUI();

        return 1;
    }

    CloseSDL();
    CloseImGUI();
    
    return EXIT_SUCCESS;
}
