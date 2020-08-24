# Manual Build Process

git checkout this repository
install a recent Docker engine
build and run the container
docker build   -t   wrf_4_tutorial   --build-arg argname=tutorial   .
docker run --name wrf4 wrf_4_tutorial sleep 100000 &

alternative for testing
docker run --rm  -it   --name  manual_wrf_4_build_test   wrf_tutorial   /bin/tcsh

exec in to manually build wrf
docker exec -it wrf4 /bin/tcsh
cd build_and_test_wrf
./build.tcsh
./test.tcsh

expect to see output as compilation and testing proceeds, which may take around nine and two minutes depending on your system
expect to see result file output in the working directory and Success Complete messages as the test script searches

create docker image from container and publish as desired
docker commit <container_id>
docker push
