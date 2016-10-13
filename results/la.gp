set terminal png
set output "la.png"

set key right bottom
set xlabel "concurrency"
set ylabel "load average"
set grid

set datafile separator ";"
plot \
    "kv.csv" using 1:6 with linespoints title "remote ets",\
    "eredis.csv" using 1:6 with linespoints title "eredis",\
    "eredis_sync.csv" using 1:6 with linespoints title "eredis\\_sync"
