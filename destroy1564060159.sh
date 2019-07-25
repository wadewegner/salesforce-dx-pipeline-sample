heroku pipelines:destroy pipeline1564060159
heroku apps:destroy -a dev1564060159 -c dev1564060159
heroku apps:destroy -a staging1564060159 -c staging1564060159
heroku apps:destroy -a prod1564060159 -c prod1564060159
rm -- "destroy1564060159.sh"
