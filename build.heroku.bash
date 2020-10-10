#!/bin/bash

echo "SOURCE_COMMIT: $SOURCE_COMMIT"

if [[ -z "$SOURCE_COMMIT_HEROKU" ]]; then
	export SOURCE_COMMIT_HEROKU="${SOURCE_COMMIT_HEROKU:-$(git rev-parse HEAD)}"
	echo "Updating SOURCE_COMMIT from git rev-parse HEAD"
	echo "SOURCE_COMMIT: $SOURCE_COMMIT_HEROKU"
	heroku config:set COMMIT_SHA=$SOURCE_COMMIT_HEROKU
fi
echo "Running CD build with git push heroku commit sha $SOURCE_COMMIT_HEROKU"
git push heroku
sleep 15
echo "Running curl https://heroku-anz-endpoint.herokuapp.com/info"
curl https://heroku-anz-endpoint.herokuapp.com/info
