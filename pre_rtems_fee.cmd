# Set the NFS user and group id

# set uid and gid to "feeioc" (10403) and "ps-ioc" (2341)
setenv ("NFS_FILE_SYSTEM_DATA","10403.2341@172.21.32.76")
setenv ("NFS_FILE_SYSTEM_EXE", "10403.2341@172.21.32.88")

. /home/All/pre_rtems.cmd
