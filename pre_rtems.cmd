#==============================================================
#
#  Abs:  IOC pre-startup initialization (Production)
#
#  Name: pre_rtems.cmd
# 
#  Facility: PCDS Controls
#
#  Auth: 27-Jul-2009, Bruce Hill (bhill)
#  Rev:  dd-mmm-yyyy, Reviewer's Name (USERNAME)
#			Based on pre_st.cmd from LCLS
#--------------------------------------------------------------
#  Mod:
#       dd-mmm-yyyy, Firstname Lastname (USERNAME):
#         comment
#
#==============================================================
#

# NTP server...
setenv ("EPICS_TS_NTP_INET","172.21.32.31")
setenv ("EPICS_TS_MIN_WEST","480")

# iocLogClient...
setenv ("EPICS_IOC_LOG_PORT", "7004")
setenv ("EPICS_IOC_LOG_INET", "172.21.32.20")
setenv ("EPICS_IOC_LOG_FILE_LIMIT","1000000")
setenv ("EPICS_IOC_LOG_FILE_COMMAND","")

# Channel access...
setenv ("EPICS_CA_AUTO_ADDR_LIST","YES")
setenv ("EPICS_CA_ADDR_LIST","")
setenv ("EPICS_CA_REPEATER_PORT","5065")
setenv ("EPICS_CA_SERVER_PORT","5064")
setenv ("EPICS_CA_CONN_TMO","10.0")
setenv ("EPICS_CA_BEACON_PERIOD","5.0")
setenv ("EPICS_CA_MAX_SEARCH_PERIOD","60.0")
setenv ("EPICS_CAS_INTF_ADDR_LIST","")
setenv ("EPICS_CAS_BEACON_ADDR_LIST","")
setenv ("EPICS_CAS_AUTO_BEACON_ADDR_LIST","")
setenv ("EPICS_CAS_SERVER_PORT","")
setenv ("EPICS_CAS_BEACON_PORT","")
setenv ("EPICS_CAS_BEACON_PERIOD","5.0")
setenv ("EPICS_CA_MAX_ARRAY_BYTES","400000")

# set path for any streamdevice protocols
setenv ("STREAM_PROTOCOL_PATH", "db")

# Mount iocData
nfsMount( getenv("NFS_FILE_SYSTEM_DATA"), "/nfsexport/datapool/iocData", "/iocData" )

# Make sure the iocData directories are ready for use
tmp_path_h	= pathSubstitute( "/iocData/%H" )
mkdir( tmp_path_h,          0775 )
tmp_path_export_iocData	= pathSubstitute("/nfsexport/datapool/iocData/%H")

# Do additional NFS mounts...
# Note: /reg/d/iocCommon/hioc/$H is already mounted by the tftp boot script as /home 
nfsMount( getenv("NFS_FILE_SYSTEM_DATA"), tmp_path_export_iocData, "/thisIocData" )
nfsMount( getenv("NFS_FILE_SYSTEM_EXE" ), "/nfsexport/datapool/iocs", "/iocs" )

# Create needed sub-directories
mkdir( "/thisIocData/iocInfo",  0775 )
mkdir( "/thisIocData/archive",  0775 )
mkdir( "/thisIocData/autosave", 0775 )
mkdir( "/thisIocData/logs",     0775 )

free( tmp_path_h              )
free( tmp_path_export_iocData )

# Enable ioc error logging
iocLogDisable=0

#End of script

