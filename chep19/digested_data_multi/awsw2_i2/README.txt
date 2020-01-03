# Command used to generate the results
for d in aria1CH_32 aria1CH_64 aria1NY_64 aria1NY_32 aria1SD_64 aria1SD_32 ; do echo $d; cat $d/digested_max.out; done
