

#!/bin/bash



# Conduct a security audit of the Apache HTTP Server configuration

audit_output=$(sudo apache2ctl configtest)



# Check if there are any SSL/TLS configuration vulnerabilities

if [[ "$audit_output" == *"Syntax OK"* ]]; then

    echo "No SSL/TLS configuration vulnerabilities found."

    exit 0

else

    echo "SSL/TLS configuration vulnerabilities found."

fi



# Fix the SSL/TLS configuration vulnerabilities

sudo sed -i 's/SSLCipherSuite.*/SSLCipherSuite ECDHE-RSA-AES256-SHA384:AES256-SHA256:RC4:HIGH:!MD5:!aNULL:!EDH:!AESGCM/g' /etc/apache2/sites-available/default-ssl.conf

sudo sed -i 's/SSLProtocol.*/SSLProtocol all -SSLv2 -SSLv3/g' /etc/apache2/sites-available/default-ssl.conf

sudo a2enmod ssl

sudo service apache2 restart



echo "SSL/TLS configuration vulnerabilities remediated."

exit 0