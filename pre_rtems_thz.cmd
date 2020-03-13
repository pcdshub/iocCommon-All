# Set the NFS user and group id

# Set uid and gid to  "thzioc" (11926) and "ps-ioc" (2341)
setenv( "NFS_FILE_SYSTEM_DATA","11926.2341@172.21.32.76" )
setenv( "NFS_FILE_SYSTEM_EXE", "11926.2341@172.21.32.88" )

. /home/All/pre_rtems.cmd
