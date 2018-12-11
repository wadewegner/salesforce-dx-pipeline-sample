heroku pipelines:destroy pipeline1544490320
heroku apps:destroy -a dev1544490320 -c dev1544490320
heroku apps:destroy -a staging1544490320 -c staging1544490320
heroku apps:destroy -a prod1544490320 -c prod1544490320
rm -- "destroy1544490320.sh"
