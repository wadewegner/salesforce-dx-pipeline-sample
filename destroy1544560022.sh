heroku pipelines:destroy pipeline1544560022
heroku apps:destroy -a dev1544560022 -c dev1544560022
heroku apps:destroy -a staging1544560022 -c staging1544560022
heroku apps:destroy -a prod1544560022 -c prod1544560022
rm -- "destroy1544560022.sh"
