#==============================================================
#
#  Abs:  Soft IOC pre-startup initialization (Production)
#
#  Name: pre_linux.cmd
#
#  Facility: LCLS Controls
#
#  Auth: 27-Jul-2009, Bruce Hill (bhill)
#  Rev:  dd-mmm-yyyy, Reviewer's Name (USERNAME)
#			Based on soft_pre_st.cmd from LCLS
#--------------------------------------------------------------
#  Mod:
#       dd-mmm-yyyy, Firstname Lastname (USERNAME):
#         comment
#
#==============================================================
#
# Time...
epicsEnvSet("EPICS_TS_NTP_INET","psntp.slac.stanford.edu")

# iocLogClient...
epicsEnvSet("EPICS_IOC_LOG_PORT","7004")
epicsEnvSet("EPICS_IOC_LOG_INET", "psloghost.pcdsn")
epicsEnvSet("EPICS_IOC_LOG_FILE_LIMIT","1000000")
epicsEnvSet("EPICS_IOC_LOG_FILE_COMMAND","")

# TODO: Need a way to conditionally set these based on the host so ioc-xcs-misc1 and others don't send CA traffic over fez
# Channel Access...
epicsEnvSet("EPICS_CA_ADDR_LIST","")
epicsEnvSet("EPICS_CA_REPEATER_PORT","5065")
epicsEnvSet("EPICS_CA_SERVER_PORT","5064")
epicsEnvSet("EPICS_CA_CONN_TMO","10.0")
epicsEnvSet("EPICS_CA_BEACON_PERIOD","5.0")
epicsEnvSet("EPICS_CA_MAX_SEARCH_PERIOD","60.0")
epicsEnvSet("EPICS_CA_AUTO_ADDR_LIST","YES")
epicsEnvSet("EPICS_CAS_INTF_ADDR_LIST","")
epicsEnvSet("EPICS_CAS_BEACON_ADDR_LIST","")
epicsEnvSet("EPICS_CAS_AUTO_BEACON_ADDR_LIST","")
epicsEnvSet("EPICS_CAS_SERVER_PORT","")
epicsEnvSet("EPICS_CAS_BEACON_PORT","")
epicsEnvSet("EPICS_CAS_BEACON_PERIOD","5.0")
epicsEnvSet("EPICS_CA_MAX_ARRAY_BYTES", "4000000")

# Enable ioc error logging
setIocLogDisable 0
