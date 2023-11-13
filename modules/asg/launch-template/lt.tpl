#!/bin/bash
# Install Apache
yum -y install httpd

# Start Apache
service httpd start

# Install PHP
yum -y install php

cat << EOF >  /var/www/html/index.php
<!DOCTYPE html>
<html>  
  <body>
    <p><?php echo "Hostname is: ", gethostname(); ?></p>
  </body>
</html>
EOF

# Restart Apache
service httpd restart