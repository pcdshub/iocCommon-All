# Set the NFS user and group id

# set uid and gid to  "xcsioc" (10667) and "ps-ioc" (2341)
setenv( "NFS_FILE_SYSTEM_DATA","10667.2341@172.21.32.73" )
setenv( "NFS_FILE_SYSTEM_EXE", "10667.2341@172.21.32.73" )

. /home/All/pre_rtems.cmd
