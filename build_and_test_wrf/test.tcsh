#!/bin/tcsh

# build WRF first with ./build.tcsh and confirm checks namely compilation success exit code and executables present

# -- NCAR included test run --
cd /wrf/WPS
ls -ls *.exe | wc -l # assert 3 confirming WPS executables are present
cp namelist.wps namelist.wps.original
cp /wrf/wrfinput/namelist.wps.docker namelist.wps
./geogrid.exe
ls -ls geo_em.d01.nc | wc -l # assert 1
./link_grib.csh /wrf/wrfinput/fnl
echo $? # assert 0
cp ungrib/Variable_Tables/Vtable.GFS Vtable
./ungrib.exe
echo $? # assert 0
ls -ls FILE* | wc -l # assert 5
./metgrid.exe
echo $?
cd /wrf/WRF/test/em_real
ln -sf ../../../WPS/met_em* .
cp namelist.input namelist.input.original  
cp /wrf/wrfinput/namelist.input.docker namelist.input
mpirun -np 4 ./real.exe
echo $? # assert 0
tail -n 1 rsl.out.0000 | grep "SUCCESS COMPLETE"
ls -ls wrfinput_d01 wrfbdy_d01 | wc -l # assert 2
#cd /wrf/WRF/test/em_real
date
date +%s
mpirun -np 4 ./wrf.exe &
date +%s
tail -n 1 rsl.out.0000 | grep -c "SUCCESS COMPLETE WRF" # assert 1
ls -ls wrfo* | wc -l # assert 9

