
echo "---------- wait for MariaDB container script to be executed -----------"
sleep 15

# check connexion and mysql server are up with statut and ping. 
mysqladmin -u ${DB_USER} -p${DB_USER_PASSWORD} -h ${DB_HOST} status
mysqladmin -u ${DB_USER} -p${DB_USER_PASSWORD} -h ${DB_HOST} ping

wp core download --locale=fr_FR --path="/var/www/html" --allow-root

wp config create    --path="/var/www/html" \
                    --dbhost=$DB_HOST \
                    --dbname=$DB_NAME \
                    --dbuser=$DB_USER \
                    --dbpass=$DB_USER_PASSWORD \
                    --allow-root

wp core install     --path="/var/www/html" \
                    --title=$WP_TITLE \
                    --admin_user=$WP_ADMIN_USER \
                    --admin_password=$WP_ADMIN_PASSWORD \
                    --admin_email=$WP_ADMIN_EMAIL \
                    --url=$WP_URL \
                    --locale=fr_FR \
                    --allow-root

wp user create $WP_USER $WP_USER_EMAIL --role=contributor --user_pass=$WP_USER_PASSWORD --allow-root

#Install and use a theme
wp theme install twentytwentyone --allow-root --activate #--force
# wp theme activate twentytwentyone --allow-root 

# run php-fpm7.3 listening for CGI request/ as a FastCGI process
exec /usr/sbin/php-fpm7.3 -F -R
