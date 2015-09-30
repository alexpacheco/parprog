set key top left
set ytics (1,2,4,8,16,32,64,128,256,512,1024)
set xtics (1,2,4,8,16,32,64,128,256,512,1024)
set logscale x
set logscale y
f(x) = x
S(x,a) = 1/(a+(1-a)/x)
set xlabel "N_{procs}"
set ylabel "Speedup"
#set label "f=0.5" at 600,2.2
#set label "f=0.1" at 600,11
#set label "f=0.01" at 600,100
#set label "f=0.001" at 600,420 rotate by 20
#set label "Linear Scaling" at 256,300 rotate by 35
#unset key
#set term post enhanced eps 22 color solid
#set output 'amdahl.eps'
set term png font "arial,14" transparent enhanced linewidth 2
set output 'amdahl.png'
plot [1:1024][1:1024] f(x) title 'Linear Scaling' lt 8, S(x,0.5) title 'f=0.5', S(x,0.1) title 'f=0.1' lt 1, S(x,0.01) title 'f=0.01' lt 7, S(x,0.001) title 'f=0.001' lt 6


