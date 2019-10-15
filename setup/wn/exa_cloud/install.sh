#
mkdir -p /opt/exa_scripts/
mkdir -p /etc/exa_cloud

download /opt/exa_scripts/exa* from .
download /opt/exa_scripts/exa* from <cloud>

ln -s /opt/exa_scripts/exa_cloud_mangle          /usr/bin/exa_cloud_mangle
ln -s /opt/exa_scripts/exa_cloud_mangle_download /usr/bin/exa_cloud_mangle_download

ln -s /opt/exa_scripts/exa_cloud_download        /usr/bin/exa_cloud_download
ln -s /opt/exa_scripts/exa_cloud_upload          /usr/bin/exa_cloud_upload
ln -s /opt/exa_scripts/exa_cloud_download_local  /usr/bin/exa_cloud_download_local

# Usa appropriate command
#echo "https://exa-us-west2.S3.amazonaws.com/%s_data" > /etc/exa_cloud/storage.conf
#echo "https://exawestp%s.blob.core.windows.net/exa-west" > /etc/exa_cloud/storage.conf
# Add separate download location, if appropriate
#echo "https://exa-us-west2.S3.amazonaws.com/%s_data" > /etc/exa_cloud/storage_downloads.conf

