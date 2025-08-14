Clone this repository.

In the folder of this repository clone the https://github.com/frenski/vizlaipedia-django.git

Run the docker compose commands to start / stop the environment.

Add the `env.py` file to the env_settings of the vizlaipedia-django app.

The config in `env.py` should be `env = 'local_docker'`


start:

   `docker compose up -d`

stop:

   `docker compose down`


If you want to restore / initialize a vizlaipedia DB add a postgresql dump named `db.sql` in the folder `restore/` and restart the docker compose setup.

Follow the output and once the restore is ready remove thte `db.sql` file from the `restore/` folder.

