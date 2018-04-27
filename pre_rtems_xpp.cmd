# Set the NFS user and group id

# set uid and gid to  "xppioc" (10666) and "ps-ioc" (2341)
setenv( "NFS_FILE_SYSTEM_DATA","10666.2341@172.21.32.76" )
setenv( "NFS_FILE_SYSTEM_EXE", "10666.2341@172.21.32.88" )

# For /nfsexport/home:
setenv( "NFS_HOME1","10665.2341@172.21.47.28" )
setenv( "NFS_HOME2","10665.2341@172.21.47.25" )
setenv( "NFS_HOME3","10665.2341@172.21.47.26" )
# Don't think this is valid any more
setenv( "NFS_HOME","10666.2341@172.21.47.20" )

< /home/All/pre_rtems.cmd
