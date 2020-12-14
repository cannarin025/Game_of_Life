\ : quit_sf 101719502 TYPE ;

{ array code}
200 constant array_x_dim
200 constant array_y_dim

array_x_dim array_y_dim * constant array_size

\ create conway_array array_size allocate drop drop

create conway_array array_size allot

create update_array array_size allot

: reset_array
    conway_array array_size 0 fill 
 ;

: reset_update_array
    update_array array_size 0 fill 
 ; 

: array_@ array_x_dim * + conway_array swap + C@ ; { takes input: x, y where x and y go from 0 - n-1}

: array_! array_x_dim * + conway_array swap + C! ; { takes input: value, x, y where x and y go from 0 - n-1}

: update_array_@ array_x_dim * + update_array swap + C@ ; { takes input: x, y where x and y go from 0 - n-1}

: update_array_! array_x_dim * + update_array swap + C! ; { takes input: value, x, y where x and y go from 0 - n-1}

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

{ cell code}

variable neighbor_sum   \ number of living neighbors a cell has
variable alive_num      \ value a cell must have to be considered alive
0 neighbor_sum !
1 alive_num !

: check_neighbors   { (x,y) check_neighbors. Checks number of neigbors of cell at (x,y)} 
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
                    swap dup rot dup rot swap   \ copies start coords for later use
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

: apply_rule { applies rules on cell (x,y) using value of neighbor_sum}
    neighbor_sum @
    case
        0 of 0 rot rot update_array_! endof { takes x,y,value --> rotates to value x,y and moves to update_array}
        1 of 0 rot rot update_array_! endof
        2 of 
            swap dup rot dup rot swap array_@ alive_num @ - 0= 
            if 
                alive_num @ rot rot update_array_!
            else
                0 rot rot update_array_!
            then
        endof
        3 of 1 rot rot update_array_! endof
        4 of 0 rot rot update_array_! endof
        5 of 0 rot rot update_array_! endof
        6 of 0 rot rot update_array_! endof
        7 of 0 rot rot update_array_! endof
        8 of 0 rot rot update_array_! endof
    endcase
;

: update_game 
    { updates update_array}

    reset_update_array

    array_y_dim 0 do
        array_x_dim 0 do
            J I check_neighbors 
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
;

: live 
    alive_num @ rot rot array_!
;

{ shapes}

{ still lifes}
: box \ box shape with bottom left corner at x,y
    1 pick 1 pick live
    1 pick 1 pick 1 + live
    1 pick 1 + 1 pick live
    1 pick 1 + 1 pick 1 + live
    drop drop

\ bmp-address @ Update_BMP
\ bmp-address @ bmp-to-screen-stretch

;

: boat \ still life with bottom left corner at x,y
    1 pick 1 + 1 pick live
    1 pick 1 pick 1 + live
    1 pick 1 pick 2 + live
    1 pick 2 + 1 pick 1 + live
    1 pick 1 + 1 pick 2 + live
    drop drop

\ bmp-address @ Update_BMP
\ bmp-address @ bmp-to-screen-stretch

;

{ non-still lifes}
: lwss \ lightweight spaceship, bottom left corner @ x,y
    1 pick 1 pick live
    1 pick 3 + 1 pick live
    1 pick 1 pick 2 + live
    1 pick 1 + 1 pick 3 + live
    1 pick 2 + 1 pick 3 + live
    1 pick 3 + 1 pick 3 + live
    1 pick 4 + 1 pick 3 + live
    1 pick 4 + 1 pick 2 + live
    1 pick 4 + 1 pick 1 + live
    drop drop

\ bmp-address @ Update_BMP
\ bmp-address @ bmp-to-screen-stretch
; 

: R-Pentomino
    1 pick 1 + 1 pick live
    1 pick 1 pick 1 + live
    1 pick 1 + 1 pick 1 + live
    1 pick 1 + 1 pick 2 + live
    1 pick 2 + 1 pick 2 + live
    drop drop 
;

: Kekw
    1 pick 1 + 1 pick live
    1 pick 2 + 1 pick live
    1 pick 3 + 1 pick live

    1 pick 1 pick 1 + live
    1 pick 4 + 1 pick  1 + live
    1 pick 11 + 1 pick 1 + live
    1 pick 12 + 1 pick 1 + live

    1 pick 1 pick 2 + live
    1 pick 4 + 1 pick 2 + live
    1 pick 4 + 1 pick 2 + live
    1 pick 5 + 1 pick 2 + live
    1 pick 6 + 1 pick 2 + live
    1 pick 7 + 1 pick 2 + live
    1 pick 8 + 1 pick 2 + live
    1 pick 9 + 1 pick 2 + live
    1 pick 10 + 1 pick 2 + live
    1 pick 13 + 1 pick 2 + live

    1 pick 1 pick 3 + live
    1 pick 14 + 1 pick 3 + live
    
    1 pick 1 + 1 pick 4 + live
    1 pick 14 + 1 pick 4 + live

    1 pick 1 pick 5 + live
    1 pick 14 + 1 pick 5 + live

    1 pick 1 pick 6 + live
    1 pick 4 + 1 pick 6 + live
    1 pick 4 + 1 pick 6 + live
    1 pick 5 + 1 pick 6 + live
    1 pick 6 + 1 pick 6 + live
    1 pick 7 + 1 pick 6 + live
    1 pick 8 + 1 pick 6 + live
    1 pick 9 + 1 pick 6 + live
    1 pick 10 + 1 pick 6 + live
    1 pick 13 + 1 pick 6 + live

    1 pick 1 pick 7 + live
    1 pick 4 + 1 pick  7 + live
    1 pick 11 + 1 pick 7 + live
    1 pick 12 + 1 pick 7 + live

    1 pick 1 + 1 pick 8 + live
    1 pick 2 + 1 pick 8 + live
    1 pick 3 + 1 pick 8 + live
    
    drop drop
;

\ reset_array
\ show_array
\ \ 1 1 1 array_!
\ \ 1 1 2 array_!
\ \ 1 2 1 array_!
\ \ 1 2 2 array_!
\ 1 1 boat
\ show_array
\ update_game
\ show_array
