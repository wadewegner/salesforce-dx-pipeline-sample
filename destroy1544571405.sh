heroku pipelines:destroy pipeline1544571405
heroku apps:destroy -a dev1544571405 -c dev1544571405
heroku apps:destroy -a staging1544571405 -c staging1544571405
heroku apps:destroy -a prod1544571405 -c prod1544571405
rm -- "destroy1544571405.sh"
