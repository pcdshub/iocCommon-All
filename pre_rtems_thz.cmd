# Set the NFS user and group id

# Set uid and gid to  "thzioc" (11926) and "ps-ioc" (2341)
setenv( "NFS_FILE_SYSTEM_DATA","11926.2341@172.21.32.76" )
setenv( "NFS_FILE_SYSTEM_EXE", "11926.2341@172.21.32.88" )

# For /nfsexport/home:
setenv( "NFS_HOME1","11926.2341@172.21.47.28" )
setenv( "NFS_HOME2","11926.2341@172.21.47.25" )
setenv( "NFS_HOME3","11926.2341@172.21.47.26" )

< /home/All/pre_rtems.cmd
