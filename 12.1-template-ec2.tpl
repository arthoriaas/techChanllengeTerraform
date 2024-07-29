# #!/bin/bash

# yum update -y
# wget https://s3.amazonaws.com/rds-downloads/rds-combined-ca-bundle.pem
# echo -e "[mongodb-org-4.0] \nname=MongoDB Repository\nbaseurl=https://repo.mongodb.org/yum/amazon/2013.03/mongodb-org/4.0/x86_64/\ngpgcheck=1 \nenabled=1 \ngpgkey=https://www.mongodb.org/static/pgp/server-4.0.asc" | sudo tee /etc/yum.repos.d/mongodb-org-4.0.repo
# sudo yum install -y mongodb-org-shell
# sudo amazon-linux-extras enable postgresql14
# sudo yum install postgresql-server -y
# sudo postgresql-setup initdb
# sudo systemctl start postgresql
# sudo systemctl enable postgresql