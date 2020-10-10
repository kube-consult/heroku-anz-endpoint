
Basic Node js Express starter code.

Code creates an object from Class config and then uses a method to populate the instantiated object with config data from a json file in the db directory.

Next an Express endpoint is established using the port number pulled from the db json file or heroku environment.

Finally a simple method GET route is set up for /info to disply the version, a commit sha from the environment variables and a description of the application as an object in json format.

Assuming you have docker installed you can build & test locally using 

git clone https://github.com/kube-consult/heroku-anz-endpoint.git

cd heroku-anz-endpoint;
./build.bash

Assuming you have heroku installed & have a heroku account you can update a continuous build using the following.

git clone https://github.com/kube-consult/heroku-anz-endpoint.git

cd heroku-anz-endpoint

create an application only required for first run.

heroku create heroku-anz-endpoint

set the container stack only required for first run.

heroku stack:set container

continuous build 

./build.heroku.bash

Or you can view my live heroku applicaiton at

https://heroku-anz-endpoint.herokuapp.com/info

