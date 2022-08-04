cd cvmfs
patch spack/py3-v4.2.0
python spack/build.py py3-v4.2.0 --dest /cvmfs/icecube.opensciencegrid.org --src icecube.opensciencegrid.org --mirror /mirror
python spack/build.py py3-v4.2.0-metaproject --dest /cvmfs/icecube.opensciencegrid.org --src icecube.opensciencegrid.org --mirror=/mirror
