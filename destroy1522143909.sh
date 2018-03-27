heroku pipelines:destroy pipeline1522143909
heroku apps:destroy -a dev1522143909 -c dev1522143909
heroku apps:destroy -a staging1522143909 -c staging1522143909
heroku apps:destroy -a prod1522143909 -c prod1522143909
rm -- "destroy1522143909.sh"
