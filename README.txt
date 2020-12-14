---------------------------------Welcome to Conway's Life in FORTH---------------------------------

a. Please run files in the following order:

    1. Conways_Life.f

        - Edit grid size at the top of this file by changine array_x_dim, array_y_dim.
        - this file will create the grid upon which life is played and define the required words to manipulate the grid.


    2. Graphics_V6_Single_Scaled_BMP_Window.f

        - This file will define all the required words to generate and display bitmap animations.
        - This file will create a new window for the game of life to run in. 


b. Use following words to run simulation:

    display_life        - runs animation using current grid until a key is pressed.
    x,y <shape_name>    - adds follwing shape to grid with bottom left corner at position (x,y). Shapes can be found at the bottom of Conways_Life.f
    reset_array         - clears life array.