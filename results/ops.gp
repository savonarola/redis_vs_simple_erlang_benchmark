set terminal png
set output "ops.png"

set key right bottom
set xlabel "concurrency"
set ylabel "ops/s"
set grid

set datafile separator ";"
plot \
    "kv.csv" using 1:3 with linespoints title "remote ets",\
    "eredis.csv" using 1:3 with linespoints title "eredis",\
    "eredis_sync.csv" using 1:3 with linespoints title "eredis\\_sync"
