to set up the jwt use cmd if powershell wont work

step 1 run -> node -e "console.log(require('crypto').randomBytes(64).toString('hex'))"
then copy the secret code and paste it in .env

        JWT_SECRET=the_generated_secret
        JWT_EXPIRES_IN=1h

step 2 run -> npm install jsonwebtoken
