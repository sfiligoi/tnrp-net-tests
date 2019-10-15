sudo /bin/bash
chown root:root POOL *config*
mv -f POOL /etc/condor/passwords.d/POOL
mv *config /etc/condor/config.d/
mkdir -p /etc/condor/scripts/
mv *config.sh /etc/condor/scripts/
