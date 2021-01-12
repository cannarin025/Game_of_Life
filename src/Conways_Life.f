{ ---------------------------------Array Code--------------------------------- }

array_x_dim array_y_dim * constant array_size

create conway_array array_size allot

create update_array array_size allot

: reset_array
    conway_array array_size 0 fill 
 ;

: reset_update_array
    update_array array_size 0 fill 
; 

: array_@ array_x_dim * + conway_array + C@ ; { takes input: x, y where x and y go from 0 - n-1}

: array_! array_x_dim * + conway_array + C! ; { takes input: value, x, y where x and y go from 0 - n-1}

: update_array_@ array_x_dim * + update_array + C@ ; { takes input: x, y where x and y go from 0 - n-1}

: update_array_! array_x_dim * + update_array + C! ; { takes input: value, x, y where x and y go from 0 - n-1}

\ : reset_array
\     array_size 0 do
\         I .
\         \ 0 conway_array I + c!
\     loop
\ ;

: show_array 
    array_size 0 do 
        I array_x_dim mod 0= 
        if 
            cr cr
        then
            conway_array I + C@ 8 .R loop
    CR 
;

: show_update_array
    array_size 0 do 
        I array_x_dim mod 0= 
        if 
            cr cr
        then
            update_array I + C@ 8 .R loop
    CR 
;

{ -------------------------------Synchronicity------------------------------- } \ this method is highly inefficient and nolonger needed.

\ array_size synchronicity * 100 / constant rule_cells_length \ length of rule_cells is the percentage of total cells given by synchronicity.
\ create rule_cells rule_cells_length allot

\ variable random_cell
\ variable array_pos

\ : reset_rule_cells 
\     rule_cells rule_cells_length array_size fill            \ initialises array with impossible value to not interfere with later stages  
\ ;

\ reset_rule_cells

\ : show_rule_cells 
\     rule_cells_length 0
\     do 
\         rule_cells I + @ .                 \ note. c@ or c! is not used here as 8 bit binary is not sufficient. A full 32 bit range is needed
\     loop
\     CR 
\ ;

\ : check_in_rule_cells
\     array_pos @                             \ copies current value of array_pos so it can be reset at the end
\     swap
\     0 array_pos !
\     dup
\     rule_cells array_pos @ + @ - 0=         \ checks if inputted value is equal to value at array_pos in rule_cells
\     array_pos @ 1 + array_pos !             \ increments array_pos
\     begin
\         1 pick                              \ duplicates inputted value
\         rule_cells array_pos @ + @ - 0=
\         or
\         array_pos @ 1 + array_pos !

\         array_pos @ rule_cells_length 1 - - 0=
\     until
\     swap
\     drop
\     swap array_pos !                        \ resets array_pos to its initial value before this word started
\ ;

\ : fill_rule_cells
\     synchronicity 100 - 0=
\     if
\         cr ." synchronicity 100% "
\         array_size 0
\         do
\             I I rule_cells + !                             \ populates array with every possible index
\         loop
\     else
\         cr ." synchronicity not 100% "
\         0 array_pos !                                       \ serves as an array length counter
\         begin 
\             array_size RND                                  \ n RND gives number in range 0 to n-1
\             random_cell !
\             random_cell @ check_in_rule_cells
\             if
\             else
\                 random_cell @ rule_cells array_pos @ + !
\                 array_pos @ 1 + array_pos !                 \ increments array length counter
\             then 
\             array_pos @ rule_cells_length 1 - >=
\         until
\     then
\ ;

\ : convert_to_1d_index       \ takes coordinates (x,y) and returns corresponding 1d array index. 
\     array_x_dim * +
\ ;

\ array_size synchronicity * 100 / constant rule_cells_length \ length of rule_cells is the percentage of total cells given by synchronicity.

\ variable rule_cells
\ rule_cells rule_cells_length 1 - cells allot drop           \ creates array of length rule_cells_length

\ variable random_cell
\ variable array_pos

\ : reset_rule_cells 
\     rule_cells_length 0                                             \ initialises array with impossible value to not interfere with later stages  
\     do
\         array_size rule_cells I cells + !                             \ populates array with every possible index
\     loop
\ ;

\ reset_rule_cells

\ : show_rule_cells 
\     rule_cells_length 0
\     do 
\         rule_cells I cells + @ .                 \ note. c@ or c! is not used here as 8 bit binary is not sufficient. A full 32 bit range is needed
\     loop
\     CR 
\ ;

\ : check_in_rule_cells
\     array_pos @                             \ copies current value of array_pos so it can be reset at the end
\     swap
\     0 array_pos !
\     dup
\     rule_cells array_pos @ cells + @ - 0=         \ checks if inputted value is equal to value at array_pos in rule_cells
\     array_pos @ 1 + array_pos !             \ increments array_pos
\     begin
\         1 pick                              \ duplicates inputted value
\         rule_cells array_pos @ cells + @ - 0=
\         or
\         array_pos @ 1 + array_pos !

\         array_pos @ rule_cells_length 1 - - 0=
\     until
\     swap
\     drop
\     swap array_pos !                        \ resets array_pos to its initial value before this word started
\ ;

\ : fill_rule_cells
\     synchronicity 100 - 0=
\     if
\         array_size 0
\         do
\             I rule_cells I cells + !                             \ populates array with every possible index
\         loop
\     else
\         0 array_pos !                                       \ serves as an array length counter
\         begin 
\             array_size RND                                  \ n RND gives number in range 0 to n-1
\             random_cell !
\             random_cell @ check_in_rule_cells
\             if
\             else
\                 random_cell @ rule_cells array_pos @ cells + !
\                 array_pos @ 1 + array_pos !                 \ increments array length counter
\             then 
\             array_pos @ rule_cells_length 1 - >=
\         until
\     then
\ ;

\ : convert_to_1d_index       \ takes coordinates (x,y) and returns corresponding 1d array index. 
\     array_x_dim * +
\ ;

{ ---------------------------------Cell Code--------------------------------- }

variable neighbor_sum       \ number of living neighbors a cell has
variable alive_num          \ value a cell must have to be considered alive
variable total_alive
variable total_alive_last   \ total number of living cells last generation
variable total_dead
variable iteration
variable born
variable died
variable activity

0 neighbor_sum !
1 alive_num !
0 total_alive !
1 total_alive_last !        \ arbitrary start value to prevent division by 0
0 total_dead !
0 iteration !
0 activity !

: get_activity
    total_alive_last @ 0=
    if
        1111111111 activity !                 \ erroneous value
    else
        total_alive @ total_alive_last @ -    \ works out difference between previous generation and current generation
        100000 *                              \ multiplies by 100000 to avoid using floats (need to divide by 100000 later for analysis)
        total_alive_last @ /                  \ divides by previous total activity to get activity * 100000
        activity !
    then
;

: check_neighbors_unwrapped   { (x,y) check_neighbors. Checks number of neigbors of cell at (x,y)} 
    0 neighbor_sum ! \ resetting neighbor sum before use
    2 -1 do         \ y loop
        2 -1 do     \ x loop
            I 2 * J + 0=  \ ignores central "starting" point
            if    
            else
                { checking the neighbor is in grid}
                swap dup J + 0 >= 
                swap dup J + array_x_dim 1 - <= 
                rot
                and 
                rot dup I + 0 >= rot
                and 
                swap dup I + array_y_dim 1 - <= rot
                and
                if 
                    1 pick 1 pick   \ copies start coords for later use
                    swap J + swap I +   \ gets indices of adjacent cells
                    array_@             \ gets value of adjacent cells. (checks cell at (x+n, y+n) for n = -1,0,1)
                    dup alive_num @ - 0=            \ checks number in cell is equal to alive num to check if adjacent cell is living
                    if 
                        neighbor_sum @ + neighbor_sum ! \ adds value to neighbor_sum
                    else
                        drop
                    then
                else
                then
            then
        loop      \ ensures that n=0 is skipped to avoid checking "current" cell
    loop  
    drop drop        \ ensures that n=0 is skipped to avoid checking "current" cell
    \ neighbor_sum @   \ puts neighbor_sum (number of surrounding alive cells) on stack
;

: check_neighbors_wrapped   { (x,y) check_neighbors. Checks number of neigbors of cell at (x,y)} 
    0 neighbor_sum !                            \ resetting neighbor sum before use
    2 -1 do                                     \ y loop
        2 -1 do                                 \ x loop
            I 2 * J + 0=                        \ ignores central "starting" point
            if    
            else 
                \ I . ." I " J . ." J" cr
                1 pick 1 pick                   \ copies start coords for later use
                swap J + swap I +               \ gets indices of adjacent cells
                
                { wrapping edges}
                dup array_y_dim - 0=
                if  
                    drop
                    0
                then
                dup 1 + 0=
                if
                    drop
                    array_y_dim 1 -
                then swap
                dup array_x_dim - 0=
                if  
                    drop
                    0
                then
                dup 1 + 0=
                if
                    drop
                    array_x_dim 1 -
                then 
                swap
                array_@                             \ gets value of adjacent cells. (checks cell at (x+n, y+n) for n = -1,0,1)
                dup alive_num @ - 0=                \ checks number in cell is equal to alive num to check if adjacent cell is living
                if 
                    neighbor_sum @ + neighbor_sum ! \ adds value to neighbor_sum
                else
                    drop
                then
            then
        loop                                        \ ensures that n=0 is skipped to avoid checking "current" cell
    loop  
    drop drop                                       \ ensures that n=0 is skipped to avoid checking "current" cell
    \ neighbor_sum @   \ puts neighbor_sum (number of surrounding alive cells) on stack
;


: apply_rule                                        \ applies rules on cell (x,y) using value of neighbor_sum
    \ 1 pick 1 pick                                   \ duplicates coords
    \ convert_to_1d_index                             \ converts 2d coordinates to 1d index to check if a rule is meant to be applied
    \ check_in_rule_cells                             \ checks to see if rules will be applied to current cell
    10001 RND synchronicity @ <=                          \ selects random number in range 10000 if < synchronicity percentage, applies life rule to cell. I.e. synchronicity percentage probability of rule being applied. Note, 10000 represents 100.00%
    if
        1 pick 1 pick array_@ alive_num @ - 0=      \ duplicates coordinates. Checks if cell at position is alive
        if                                          \ code for living cells
            neighbor_sum @ check_in_S               \ checks if cell is subject to survival conditions. Birth condition ignored if cell was already alive.
            if
                alive_num @ rot rot update_array_!
                total_alive @ 1 + total_alive !     \ increments total number of living cells
            else                                    \ if cell does not survive ==> dies
                0 rot rot update_array_!            \ Does not duplicate coordinates to leave stack empty
                died @ 1 + died !
            then   

        else                                        \ code for dead cells
            neighbor_sum @ check_in_B               \ checks if cell is subject birth. Survival ignored if cell was already dead.
            if
                alive_num @ rot rot update_array_!  \ cell comes to life
                total_alive @ 1 + total_alive !
                born @ 1 + born ! 
            else                                    \ stays dead
                0 rot rot update_array_!            \ Does not duplicate coordinates to leave stack empty
            then   
        then

    else                                            \ Does nothing: living cell stays alive, dead cell stays dead
        1 pick 1 pick array_@ alive_num @ - 0=      \ duplicates coordinates. Checks if cell at position is alive
        if
            alive_num @ rot rot update_array_!
            total_alive @ 1 + total_alive !
        else
            0 rot rot update_array_!                \ increments total number of living cells
        then
    then
    array_size total_alive @ - total_dead !         \ total number of dead cells = max cells - living cells
;

: update_game_unwrapped 
    { updates update_array}

    reset_update_array

    0 total_alive !
    0 total_dead !
    0 born !
    0 died !

    array_y_dim 0 do
        array_x_dim 0 do
            J I check_neighbors_unwrapped 
            J I apply_rule
        loop
    loop

    { reads update array and updates conway_array}
    array_y_dim 0 do
        array_x_dim 0 do
            I J update_array_@
            I J array_!
        loop
    loop

    get_activity                        \ sets activity
    total_alive @ total_alive_last !    \ updates total_alive_last for next iteration

    iteration @ 1 + iteration !
;

: update_game_wrapped
    { updates update_array}

    0 total_alive !
    0 total_dead !
    0 born !
    0 died !

    reset_update_array

    array_y_dim 0 do
        array_x_dim 0 do
            J I check_neighbors_wrapped
            J I apply_rule
        loop
    loop

    { reads update array and updates conway_array}
    array_y_dim 0 do
        array_x_dim 0 do
            I J update_array_@
            I J array_!
        loop
    loop

    get_activity                        \ sets activity
    total_alive @ total_alive_last !    \ updates total_alive_last for next iteration

    iteration @ 1 + iteration !
    
;

: live 
    alive_num @ rot rot array_!
;
