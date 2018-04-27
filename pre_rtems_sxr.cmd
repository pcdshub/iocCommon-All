# Set the NFS user and group id

# set uid and gid to  "sxrioc" (10665) and "ps-ioc" (2341)
setenv( "NFS_FILE_SYSTEM_DATA","10665.2341@172.21.32.76" )
setenv( "NFS_FILE_SYSTEM_EXE", "10665.2341@172.21.32.88" )

# For /nfsexport/home:
setenv( "NFS_HOME1","10665.2341@172.21.47.28" )
setenv( "NFS_HOME2","10665.2341@172.21.47.25" )
setenv( "NFS_HOME3","10665.2341@172.21.47.26" )
#Add HOME4 + HOME5

< /home/All/pre_rtems.cmd
