heroku pipelines:destroy pipeline1521514727
heroku apps:destroy -a dev1521514727 -c dev1521514727
heroku apps:destroy -a staging1521514727 -c staging1521514727
heroku apps:destroy -a prod1521514727 -c prod1521514727
rm -- "destroy1521514727.sh"
