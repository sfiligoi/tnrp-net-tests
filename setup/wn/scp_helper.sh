sudo /bin/bash
chown root:root POOL *conf* exa*
mv -f POOL /etc/condor/passwords.d/POOL

mv *storage*conf /etc/exa_cloud/regions/
mv *local.config /etc/condor/regions

mv exa* /opt/exa_scripts/

mv *config /etc/condor/config.d/
mv *config.sh /etc/condor/scripts/
