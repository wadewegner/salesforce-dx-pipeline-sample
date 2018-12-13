heroku pipelines:destroy pipeline1544573736
heroku apps:destroy -a dev1544573736 -c dev1544573736
heroku apps:destroy -a staging1544573736 -c staging1544573736
heroku apps:destroy -a prod1544573736 -c prod1544573736
rm -- "destroy1544573736.sh"
