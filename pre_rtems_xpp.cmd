# Set the NFS user and group id

# set uid and gid to  "xppioc" (10666) and "ps-ioc" (2341)
setenv( "NFS_FILE_SYSTEM_DATA","10666.2341@172.21.32.76" )
setenv( "NFS_FILE_SYSTEM_EXE", "10666.2341@172.21.32.88" )

. /home/All/pre_rtems.cmd
