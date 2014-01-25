isim force add {/des_top/datain} 000000000000000 -radix hex 
isim force add {/des_top/key} 10316E028C8F3B4A -radix hex

isim force add {/des_top/clk} 1 -radix bin -value 0 -radix bin -time 500 ns -repeat 1 us 

isim force add {/des_top/encrypt} 1 -radix bin 
isim force add {/des_top/rst} 1 -radix bin 
isim force add {/des_top/soc} 0 -radix bin 

run 1.00us
 
isim force add {/des_top/soc} 1 -radix bin 

isim force add {/des_top/rst} 0 -radix bin 

run 16.00us

isim force add {/des_top/soc} 0 -radix bin


isim force add {/des_top/datain} 82dcbafbdeab6602 -radix hex

isim force add {/des_top/encrypt} 0 -radix bin 

isim force add {/des_top/soc} 1 -radix bin 

run 20.00us