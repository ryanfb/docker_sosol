docker_sosol
============

A Dockerfile for building and testing the Rails 3 version of [SoSOL](https://github.com/sosol/sosol) and running a development server.
 
* Test the build with `docker build .`
* Tag the build with `docker build -t sosol .`
* Run the build with `docker run -d --name sosol_dev -p 3000:3000 sosol`
* Access e.g. [localhost:3000](http://localhost:3000/) in a browser

Note:
-----
This currently expects `*_secret.rb` files in the Docker build context, for RPX API keys. Eventually with the removal of Janrain (see [#42](https://github.com/sosol/sosol/issues/42)) this should no longer be required.
