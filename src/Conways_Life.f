\ : quit_sf 101719502 TYPE ;

{ array code}
\ 200 constant array_x_dim          Array size defined in main.f
\ 200 constant array_y_dim

array_x_dim array_y_dim * constant array_size

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
variable total_alive
variable total_dead
variable iteration
0 neighbor_sum !
1 alive_num !
0 total_alive !
0 total_dead !
0 iteration !

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

: check_neighbors_wrapped   { (x,y) check_neighbors. Checks number of neigbors of cell at (x,y)} 
    0 neighbor_sum ! \ resetting neighbor sum before use
    2 -1 do         \ y loop
        2 -1 do     \ x loop
            I 2 * J + 0=  \ ignores central "starting" point
            if    
            else 
                \ I . ." I " J . ." J" cr
                swap dup rot dup rot swap   \ copies start coords for later use
                swap J + swap I +   \ gets indices of adjacent cells
                
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
                then swap

                \ swap dup rot dup rot . ." checking x   " . ." checking y" cr

                array_@             \ gets value of adjacent cells. (checks cell at (x+n, y+n) for n = -1,0,1)
                dup alive_num @ - 0=            \ checks number in cell is equal to alive num to check if adjacent cell is living
                if 
                    neighbor_sum @ + neighbor_sum ! \ adds value to neighbor_sum
                else
                    drop
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
                total_alive @ 1 + total_alive !
            else
                0 rot rot update_array_!
            then
        endof
        3 of alive_num @ rot rot update_array_! total_alive @ 1 + total_alive ! endof
        4 of 0 rot rot update_array_! endof
        5 of 0 rot rot update_array_! endof
        6 of 0 rot rot update_array_! endof
        7 of 0 rot rot update_array_! endof
        8 of 0 rot rot update_array_! endof
    endcase

    array_size total_alive @ - total_dead !

;

: update_game_unwrapped 
    { updates update_array}

    reset_update_array

    0 total_alive !
    0 total_dead !

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

    iteration @ 1 + iteration !
;

: update_game_wrapped
    { updates update_array}

    0 total_alive !
    0 total_dead !

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

    iteration @ 1 + iteration !
    
;

: live 
    alive_num @ rot rot array_!
;

