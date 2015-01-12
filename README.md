docker_sosol
============

A Dockerfile for building and testing the Rails 3 version of [SoSOL](https://github.com/sosol/sosol) and running a development server.
 
* Test the build with `docker build .`
* Tag the build with `docker build -t sosol .`
* Run the build with `docker run -d --name sosol_dev sosol`
* Find the mapped port with `docker port sosol_dev 3000`, then access it in a browser
