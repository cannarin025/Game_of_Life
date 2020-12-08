\ : quit_sf 101719502 TYPE ;

{ array code}
20 constant array_x_dim
20 constant array_y_dim

array_x_dim array_y_dim * constant array_size

create conway_array array_size allocate drop drop

\ : reset_array { fill does not work for now. Will write version of this without using fill}
\     conway_array array_size 0 fill 
\  ;

: array_@ array_x_dim * + conway_array swap + C@ ; { takes input: x, y where x and y go from 0 - n-1}

: array_! array_x_dim * + conway_array swap + C! ; { takes input: value, x, y where x and y go from 0 - n-1}

\ : reset_array
\     array_size 1 - 0 do
\         0 conway_array I + c!
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

{ cell code}

variable neighbor_sum   \ number of living neighbors a cell has
variable alive_num      \ value a cell must have to be considered alive
0 neighbor_sum !
1 alive_num !

: check_neighbors   { (x,y) check_neighbors. Checks number of neigbors of cell at (x,y)} 
    0 neighbor_sum ! \ resetting neighbor sum before use
    2 -1 do         \ x loop
        2 -1 do     \ y loop
            I 2 * J + 0=  \ ignores central "starting" point
            if
            \ ." pass" cr    
            else
                dup swap dup swap   \ copies start coords for later use
                J + swap I + swap   \ gets indices of adjacent cells
                \ dup . swap dup . swap ." indices" cr \ displays indices
                array_@             \ gets value of adjacent cells. (checks cell at (x+n, y+n) for n = -1,0,1)
                dup alive_num @ - 0=            \ checks number in cell is equal to alive num to check if adjacent cell is living
                if
                    \ dup .    
                    neighbor_sum @ + neighbor_sum ! \ adds value to neighbor_sum
                    \ ." value equal to alive_num" cr cr
                else
                    \ ." value not equal to alive_num" cr cr
                    drop
                then
            then
        loop      \ ensures that n=0 is skipped to avoid checking "current" cell
    loop  
    drop drop        \ ensures that n=0 is skipped to avoid checking "current" cell
    \ neighbor_sum @   \ puts neighbor_sum (number of surrounding alive cells) on stack
;

: apply_rule { applies rules on current cell using value of neighbor_sum}
    neighbor_sum @
    case
        1 of ."  1 living neighbor" endof
        2 of ."  2 living neighbors" endof
        3 of ."  3 living neighbors" endof
        4 of ."  4 living neighbors" endof
        5 of ."  5 living neighbors" endof
        6 of ."  6 living neighbors" endof
        7 of ."  7 living neighbors" endof
        8 of ."  8 living neighbors" endof
        drop DUP OF ."  no living neighbors found" endof
    endcase
;

\ reset_array
show_array
1 1 2 array_!
1 1 1 array_!
1 2 2 array_!
1 0 0 array_!
show_array
1 1 check_neighbors
apply_rule
