if [ ! -d $IOC_DATA/$IOC ]; then
$RUNUSER "mkdir $IOC_DATA/$IOC"
$RUNUSER "setfacl -d -m group:ps-ioc:rwx $IOC_DATA/$IOC"
$RUNUSER "setfacl    -m group:ps-ioc:rwx $IOC_DATA/$IOC"
$RUNUSER "mkdir -p $IOC_DATA/$IOC/autosave"
$RUNUSER "mkdir -p $IOC_DATA/$IOC/archive"
$RUNUSER "mkdir -p $IOC_DATA/$IOC/iocInfo"
$RUNUSER "mkdir -p $IOC_DATA/$IOC/logs"
$RUNUSER "chmod ug+w -R $IOC_DATA/$IOC"
fi
