# Set the NFS user and group id

# set uid and gid to "feeioc" (10403) and "ps-ioc" (2341)
# using 172.21.32.76
# and   172.21.32.88
setenv ("NFS_FILE_SYSTEM_DATA","10403.2341@172.21.32.76")
#setenv ("NFS_FILE_SYSTEM_EXE", "10403.2341@172.21.32.28")
setenv ("NFS_FILE_SYSTEM_EXE", "10403.2341@172.21.32.88")

# For /nfsexport/home:
# setenv( "NFS_HOME","10403.2341@172.21.47.28" )
# setenv( "NFS_HOME1","10664.2341@172.21.47.28" )
setenv( "NFS_HOME1","10664.2341@172.21.32.81" )
setenv( "NFS_HOME2","10664.2341@172.21.47.25" )
setenv( "NFS_HOME3","10664.2341@172.21.47.26" )


< /home/All/pre_rtems.cmd
