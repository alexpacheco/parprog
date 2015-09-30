set key top left
set xlabel "N_{procs}"
set ylabel "Speedup"
set term png font "arial,18" transparent enhanced linewidth 2
set output 'speedup.png'
unset xtics
unset ytics
set border 3
set label 'Ideal' at 1,1.05 rotate by 38
set label 'Reality' at 1.4,1.05
plot [0:1.8] x t '' lw 2 lt 8, sin(x) t '' lw 2 lt 7



