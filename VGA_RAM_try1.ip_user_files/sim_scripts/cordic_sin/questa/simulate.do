onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib cordic_sin_opt

do {wave.do}

view wave
view structure
view signals

do {cordic_sin.udo}

run -all

quit -force
