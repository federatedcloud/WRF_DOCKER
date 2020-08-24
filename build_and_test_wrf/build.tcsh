#!/bin/tcsh
cd /wrf/WRF
./clean -a
echo '34\n1\n' | ./configure
./compile em_real > & ! foo    # 9 minutes
echo $? # assert 0
ls -ls main/*.exe
ls -ls main/*.exe | wc -l # assert 4
cd ../WPS
echo "1\n" | ./configure
grep -c lnetcdff ./configure.wps # assert 1
./compile >&! foo
echo $? # assert 0
ls -ls *.exe | wc -l # assert 3
