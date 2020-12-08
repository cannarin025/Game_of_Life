\ : quit_sf 101719502 TYPE ;

{ array code}
10 constant array_x_dim
10 constant array_y_dim

array_x_dim array_y_dim * constant array_size

create conway_array array_size allocate drop drop

: reset_array
    conway_array array_size 0 fill
;

reset_array

: show_array 
    array_size 0 do 
        I array_x_dim mod 0= 
        if 
            cr cr
        then
            conway_array I + C@ 8 .R loop
    CR 
;

: array_@ array_x_dim * + conway_array swap + C@ ; { takes input: x, y where x and y go from 0 - n-1}

: array_! array_x_dim * + conway_array swap + C! ; { takes input: value, x, y where x and y go from 0 - n-1}

{ cell code}

variable neighbor_sum   \ number of living neighbors a cell has
variable alive_num      \ value a cell must have to be considered alive
0 neighbor_sum !
1 alive_num !

: check_neighbors   { (x,y) check_neighbors. Checks number of neigbors of cell at (x,y)} 
    2 -1 do         \ x loop
        I . ."  I counter " cr    \ testing 
        2 -1 do     \ y loop
            J . ."  J counter" cr \ testing
            J + swap I + swap array_@       \ gets value of adjacent cells. (checks cell at (x+n, y+n) for n = -1,0,1)
            dup alive_num @ - 0=            \ checks number in cell is equal to alive num to check if adjacent cell is living
            if    
                neighbor_sum @ + neighbor_sum !
                neighbor_sum @ \ test
            then
        2 +loop      \ ensures that n=0 is skipped to avoid checking "current" cell
    2 +loop          \ ensures that n=0 is skipped to avoid checking "current" cell
    neighbor_sum @   \ puts neighbor_sum (number of surrounding alive cells) on stack
    0 neighbor_sum ! \ resetting neighbor_sum for next use
;

: apply_rule { applies rules on current cell using value of neighbor_sum from top of stack}
    case
        1 of ."  1 living neighbor" drop endof
        2 of ."  2 living neighbors" drop endof
        3 of ."  3 living neighbors" drop endof
        4 of ."  4 living neighbors" drop endof
        5 of ."  5 living neighbors" drop endof
        6 of ."  6 living neighbors" drop endof
        7 of ."  7 living neighbors" drop endof
        8 of ."  8 living neighbors" drop endof
        drop DUP OF ."  no living neighbors found" endof
    endcase
;

reset_array
show_array
1 1 2 array_!
1 1 1 array_!
1 1 check_neighbors
show_array