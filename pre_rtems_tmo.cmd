# Set the NFS user and group id

# set uid and gid to "tmoioc" (16914) and "ps-ioc" (2341)
setenv( "NFS_FILE_SYSTEM_DATA","16914.2341@172.21.32.73" )
setenv( "NFS_FILE_SYSTEM_EXE", "16914.2341@172.21.32.73" )

. /home/All/pre_rtems.cmd
