## First create Rails app

    rails new --database postgresql --api nuxt-rails-a-la-webpacker 

## Then the Nuxt app in Frontend folder

    yarn create nuxt-app frontend  

Move package.json & nuxt.config.js to the root

    mv frontend/package.json package.json  
    mv frontend/nuxt.config.js nuxt.config.js  

And tell Nuxt the app is in `frontend/` in nuxt.config.js :

    srcDir: 'frontend/'

Set Nuxt to run on port 8080 :
package.json

    "config": {  
        "nuxt": {  
    	    "port": "8080"  
        }  
    },

## Heroku config

We'll deploy an app for the backend and another for frontend to Heroku 
So we need 2 Procfiles and tell Heroku where the Procfile is located for each app

The Rails Procfile stay at the root :

    touch Procfile << ECHO "web: bundle exec puma -C config/puma.rb"  

The Nuxt Procfile is in frontend folder :

    touch frontend/Procfile << ECHO "web: npm start"  

Create frontend app on Heroku :

    heroku apps:create nuxt-rails-client --region=eu  

and rename the remote frontend :

    git remote rename heroku frontend  

Add [multi-procfile buildpack](https://github.com/heroku/heroku-buildpack-multi-procfile) 

    heroku buildpacks:add -r frontend https://github.com/heroku/heroku-buildpack-multi-procfile

Set the Procfile path 

    heroku config:set PROCFILE=frontend/Procfile -r frontend  

and [follow this guide to set Nuxt for production](nuxtjs.org/faq/heroku-deployment/)
  
Deploy the backend

    heroku apps:create nuxt-rails-backend --region=eu  
    git remote rename heroku backend  
    heroku config:set API_URL=nuxt-rails-backend.herokuapp.com -r backend  
    heroku run rails db:seed -r backend

