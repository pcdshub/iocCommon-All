# Set the NFS user and group id

# set uid and gid to  "xcsioc" (10667) and "ps-ioc" (2341)
setenv( "NFS_FILE_SYSTEM_DATA","10667.2341@172.21.32.76" )
setenv( "NFS_FILE_SYSTEM_EXE", "10667.2341@172.21.32.88" )

# For /nfsexport/home:
setenv( "NFS_HOME","10667.2341@172.21.47.20" )

< /home/All/pre_rtems.cmd
