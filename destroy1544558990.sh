heroku pipelines:destroy pipeline1544558990
heroku apps:destroy -a dev1544558990 -c dev1544558990
heroku apps:destroy -a staging1544558990 -c staging1544558990
heroku apps:destroy -a prod1544558990 -c prod1544558990
rm -- "destroy1544558990.sh"
