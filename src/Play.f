{ ---------------------File containing words required to play a game of life---------------------- }

: Show                                { Update bmp and display to match changes in conway_array}
  bmp-address @ Update_BMP            { Copy conway_array as BMP                        }
  bmp-address @ bmp-to-screen-stretch { Stretch .bmp to display window                  }
;

: init_life                           { Create life window with variable pixel size}
  clear_stack
  ." Creating life stretch BMP window"
  0 iteration !
  New-bmp-Window-stretch
  bmp-window-handle !
  reset_array
  Show
;

: play_life                           { Draw bmp to screen at variable pixel size       }
  clear_stack
  Make_Sim_File
  cr ." Starting stretch to window test " 
  cr
  0 iteration !
  0 total_alive_last !
  begin                               { Begin update / display loop                     }
  Show
  100 ms                              { Delay for viewing ease, reduce for higher speed }
  update_game_unwrapped               { Run next iteration of life}
  Write_Sim_Data
  key?                                { Break test loop on key press                    }
  until
  End_Sim_File 
  ;

: play_life_wrapped
  clear_stack
  Make_Sim_File
  cr ." Starting stretch to window test " 
  cr
  0 iteration !
  0 total_alive_last !
  begin                               { Begin update / display loop                     }
  Show
  100 ms                              { Delay for viewing ease, reduce for higher speed }
  update_game_wrapped                 { Run next iteration of life}
  Write_Sim_Data
  key?                                { Break test loop on key press                    }
  until 
  End_Sim_File
;