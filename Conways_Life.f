\ : quit_sf 101719502 TYPE ;

{ array code}
5 constant array_x_dim
5 constant array_y_dim

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
            \ ." pass" cr    
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
                    \ dup . swap dup . swap ." indices" cr \ displays indices
                    array_@             \ gets value of adjacent cells. (checks cell at (x+n, y+n) for n = -1,0,1)
                    dup alive_num @ - 0=            \ checks number in cell is equal to alive num to check if adjacent cell is living
                    if
                        \ dup .    
                        neighbor_sum @ + neighbor_sum ! \ adds value to neighbor_sum
                        \ ." value equal to alive_num" cr cr
                    else
                        ." value not equal to alive_num" cr
                        drop
                    then
                else
                    I . ." I " J . ." J not in grid" cr cr
                then
            then
        loop      \ ensures that n=0 is skipped to avoid checking "current" cell
    loop  
    drop drop        \ ensures that n=0 is skipped to avoid checking "current" cell
    \ neighbor_sum @   \ puts neighbor_sum (number of surrounding alive cells) on stack
;

: apply_rule { applies rules on cell (x,y) using value of neighbor_sum}
    swap dup . ." x " swap dup . ." y" cr
    neighbor_sum @
    case
        0 of 0 rot rot update_array_! ." no alive neighbors" show_update_array cr cr endof { takes x,y,value --> rotates to value x,y and moves to update_array}
        1 of 0 rot rot update_array_! ."  1 living neighbor" show_update_array cr cr endof
        \ 2 of 0 rot rot update_array_! endof
        3 of 1 rot rot update_array_! ."  3 living neighbors" show_update_array cr cr endof
        4 of 0 rot rot update_array_! ."  4 living neighbors" show_update_array cr cr endof
        5 of 0 rot rot update_array_! ."  5 living neighbors" show_update_array cr cr endof
        6 of 0 rot rot update_array_! ."  6 living neighbors" show_update_array cr cr endof
        7 of 0 rot rot update_array_! ."  7 living neighbors" show_update_array cr cr endof
        8 of 0 rot rot update_array_! ."  8 living neighbots" show_update_array cr cr endof
        \ drop DUP OF ."  no living neighbors found" endof
    endcase
    cr cr
;

: update_game 
    { updates update_array}

    reset_update_array

    array_y_dim 0 do
        array_x_dim 0 do
            J I check_neighbors 
            J I apply_rule
            cr cr cr cr cr cr cr 
        loop
    loop

    show_update_array

    { reads update array and updates conway_array}
    array_y_dim 0 do
        array_x_dim 0 do
            I J update_array_@
            I J array_!
        loop
    loop
;

{ shapes}
: boat \ still life with bottom left corner at x,y
1 1 pick 1 + 1 pick array_!
1 1 pick 1 pick 1 + array_!
1 1 pick 1 pick 2 + array_!
1 1 pick 2 + 1 pick 1 + array_!
1 1 pick 1 + 1 pick 2 + array_!
drop drop 
;

reset_array
show_array
1 1 1 array_!
1 1 2 array_!
1 2 1 array_!
1 2 2 array_!
\ 1 1 boat
show_array
update_game
show_array
