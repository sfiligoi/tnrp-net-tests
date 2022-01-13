yum install certbot
certbot certonly -d icecube-cloud-t4-ce.t2.ucsd.edu
cp /etc/letsencrypt/live/icecube-cloud-t4-ce.t2.ucsd.edu/cert.pem /etc/grid-security/hostcert.pem
cp /etc/letsencrypt/live/icecube-cloud-t4-ce.t2.ucsd.edu/privkey.pem /etc/grid-security/hostkey.pem
