heroku pipelines:destroy pipeline1573309578
heroku apps:destroy -a dev1573309578 -c dev1573309578
heroku apps:destroy -a staging1573309578 -c staging1573309578
heroku apps:destroy -a prod1573309578 -c prod1573309578
rm -- "destroy1573309578.sh"
