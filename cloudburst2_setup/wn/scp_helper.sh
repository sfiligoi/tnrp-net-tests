sudo /bin/bash
chown root:root POOL *conf* exa* validate_cvmfs.sh
mv -f POOL /etc/condor/passwords.d/POOL

mv *storage*conf *cvmfs.conf /etc/exa_cloud/regions/
mv *local.config /etc/condor/regions

mv exa_region_setup.sh /opt/exa_cloud/exa_region_setup.sh
mv exa-region-setup.service /usr/lib/systemd/system/exa-region-setup.service

mv exa* /opt/exa_scripts/

mv *config /etc/condor/config.d/
mv *config.sh validate_cvmfs.sh /etc/condor/scripts/
