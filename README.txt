------------------------------------------------------------------------Welcome to Conway's Life in FORTH------------------------------------------------------------------------

Warning: Before playing life, please open /src/Graphics_V6_Single_Scaled_BMP_Window.f to set a valid file path where the data from each simulation can be saved.

To play life please run Main.f.

    Adjustable parameters:
        - The size of the array can be edited by changing the values of the constants at the top of Main.f
        - The rules of the Game of Life can be varied by editing the values for S and B in the relevant place in Ruleset.f. Please supply values in the range <None> to 8.
        - The synchronicity of the Game of Life i.e. the probability any cell will have rules applied each iteration can be varied in Main.f
            - Synchronicity investigations should be conducted using periodic boundary conditions i.e. wrapped edges.
        - The max number of iterations that the game will run for can be varied by editing the value of max_iterations in main.f.
            - Note the max number of iterations only applies when the word run_test is used to play life.

    If any issues are encountered, please force-restart SwiftForth

    - You will see 2 windows appear. 
            - BMP Window will display your life array. 
            - Life Statistics will display statistics about the running game.

                Note: 
                        -Life statistics displays activity * 100000, please divide out this factor when performing analysis
                        -If Life Statistics is closed, please re-run Main.f to create a new window.

    - To use this program please use the following words in the FORTH console:

            Play_Life           - Runs animation using current grid without wrapping until a key is pressed.
            Play_Life_Wrapped   - Runs animation using current grid with wrapping until a key is pressed.
            x y <shape_name>    - Adds follwing shape to grid with bottom left corner at position (x,y). Shapes can be found in shapes.f.
            Show                - Updates graphical display. example use: 50 50 lwss show. This will create an lwss at (x,y) = 50, 50 and update the graphical display.
            Reset_Array         - Clears life array.
            Init_Life           - Use to restart life from console should the display window be closed accidentally.

    - Running a simulation will cause a file to be created at <filepath> which will store the simulation statistics in a CSV until the a key is pressed and the simulation ends.

        Warning: Please open /src/Graphics_V6_Single_Scaled_BMP_Window.f to set a valid <filepath> where the data CSV can be saved
        
        Note: This file will be overwritten each time a simulation plays. Be sure to rename the file afterwards if you want to keep the results.

    - Create and test different lifes by adding them to /src/Lifes.f

This project is structured as follows:

    Main.f                      - Main file to run program
    /Data                       - Directory storing data from simulation
    /src                        - Directory containing backend code.
    /Exercises                  - Directory containing FORTH introductory exercises (ignore)

        /src/Conways_Life.f                         - File containing FORTH words to create and update life array.
        /src/Graphics_V6_Single_Scaled_BMP_Window   - File containing FORTH words to handle displaying.
        /src/Lifes.f                                - File containing FORTH words to create different Lifes.
        /src/Rnd.f                                  - File containing FORTH words to generate random numbers.
        /src/Test_File_IO_Tools.f                   - File containing FORTH words to create and save data CSV file.
        /src/Text_Output_Window_V1.f                - File containing FORTH words to display life statistics in separate window.
        /src/Play.f                                 - File containing FORTH words to play game of life.
        /src/Ruleset.f                              - File containing FORTH words governing ruleset.