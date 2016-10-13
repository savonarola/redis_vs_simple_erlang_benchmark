set terminal png
set output "latency.png"

set key right bottom
set xlabel "concurrency"
set ylabel "latency, ms"
set grid

set datafile separator ";"
plot \
    "kv.csv" using 1:4 with linespoints title "remote ets",\
    "eredis.csv" using 1:4 with linespoints title "eredis",\
    "eredis_sync.csv" using 1:4 with linespoints title "eredis\\_sync"
