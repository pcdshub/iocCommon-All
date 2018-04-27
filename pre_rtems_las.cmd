# Set the NFS user and group id

# set uid and gid to  "lasioc" (10664) and "ps-ioc" (2341)
setenv( "NFS_FILE_SYSTEM_DATA","10664.2341@172.21.32.76" )
setenv( "NFS_FILE_SYSTEM_EXE", "10664.2341@172.21.32.88" )

# For /nfsexport/home:
setenv( "NFS_HOME1","10664.2341@172.21.47.28" )
setenv( "NFS_HOME2","10664.2341@172.21.47.25" )
setenv( "NFS_HOME3","10664.2341@172.21.47.26" )

< /home/All/pre_rtems.cmd
