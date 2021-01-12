{ Array parameters}

600 constant array_x_dim
600 constant array_y_dim

{ Array synchronicity as percentage}
variable synchronicity
10000 synchronicity !      \ Sycnronicity 10000 represents 100.00% to allow for 2 decimal place precision

{ Time delay between Game of Life iterations in ms}
1 constant iteration_delay

{ Max number of iterations game will run for}
variable max_iterations
30000 max_iterations !     \ This is the max number of iterations that run_test will run for. play_life is unaffected.

Include src/Rnd.f
Include src/Utilities.f
Include src/Ruleset.f
Include src/Conways_Life.f
Include src/Lifes.f
Include src/Text_Output_Window_V1.f
Include src/File_IO_Tools.f
Include src/Graphics_V6_Single_Scaled_BMP_Window.f
Include src/Lifes.f
Include src/Play.f

init_life