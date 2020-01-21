sudo /bin/bash
chown root:root POOL *config squid_customize.sh
mv -f POOL /etc/condor/passwords.d/POOL
mv *config /etc/condor/config.d/
mv squid_customize.sh /etc/squid/customize.sh
