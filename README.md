# Application Swift 3

Cloner le dépot Git. 

Lancer XCode. (url de l'API en dur au debut de chaque controleur, à modifier si besoin)

Terminé !

# API (Laravel 5.4)

Récupérer ce dépot Bitbucket : https://bitbucket.org/Jucau/betswift

Monter une VM en ajoutant une carte réseau privé

Lancer la VM (avec PHP7-MySQL-Apache2-Composer)

Création d'un proxy pour ramener vers php artisan serve:
  
  - sudo a2enmod proxy
  - sudo a2enmod rewrite
  - sudo a2enmod proxy_http
  - sudo nano /etc/apache2/sites-available/000-default.conf
  
        <VirtualHost *:80>

          <Location />
                  ProxyPass http://127.0.0.1:8000/
                  ProxyPassReverse http://127.0.0.1:8000/
          </Location>

          ErrorLog ${APACHE_LOG_DIR}/error.log
          CustomLog ${APACHE_LOG_DIR}/access.log combined
        
        </VirtualHost>
    
   - sudo service apache2 restart
   

Lancer une procédure d'installation classique Laravel (aller dans le dossier du git clone):
 - config du .env 
 - composer install
 - php artisan key:generate
 - creation de la base de données
 - php artisan migrate --seed
 - php artisan passport:install
 - php artisan serve
