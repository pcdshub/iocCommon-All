#==============================================================
#
#  Abs:  IOC post-startup initialization (Production)
#
#  Name: post_rtems.cmd
#
#  Facility: PCDS Controls
#
#  Auth: 27-Jul-2009, Bruce Hill (bhill)
#  Rev:  dd-mmm-yyyy, Reviewer's Name (USERNAME)
#			Based on post_st.cmd from LCLS
#--------------------------------------------------------------
#  Mod:
#       dd-mmm-yyyy, Firstname Lastname (USERNAME):
#         comment
#
#=================================================================================================================
#
# Let's do some post startup things:
#

# First we will lower the shell priority to protect high priority tasks
# against all of this data dump that will be used by programs like IRMIS
# rtems_task_set_priority(rtems_id task_id, rtems_task_priority new_priority, rtems_task_priority *p_old_priority);
# Initialize a variable:
# =================================================================================================================
lcls_old_pri = 444
rtems_task_set_priority(0, 150, &lcls_old_pri)
# =================================================================================================================


# Let's Get EPICS version:
iocshCmd("coreRelease > /thisIocData/iocInfo/IOC.epicsVersion")

# Let's Get EPICS environment:
iocshCmd("epicsEnvShow > /thisIocData/iocInfo/IOC.epicsEnvShow")

#
# Let's Get OS version:
#version() > /iocInfo/IOC.rtemsVersion

#
# Let's Get vxWorks BSP version:
#printf("%s\n",sysBspRev()) >/thisIocData/iocInfo/IOC.bspVersion

#
# Let's Get loaded module information:
Xfp= fopen("/thisIocData/iocInfo/IOC.modules","w")
cexpModuleInfo(0,0,Xfp)
fclose(Xfp)

# Dump a list of all PVs to a file on the Boot Server:
# The pvs name will be written to a file along with its record type.
# The location on the boot server follows:
# /usr/local/lcls/epics/iocCommon/IOC_NET_NAME/iocInfo
iocshCmd("dbl '' RTYP > /thisIocData/iocInfo/IOC.pvlist")
iocshCmd("dbl '' DTYP > /thisIocData/iocInfo/IOC.DTYP")

# Let's get the hardware info from the IOC to the boot server
iocshCmd("dbhcr > /thisIocData/iocInfo/IOC.dbhcr")
iocshCmd("dbior > /thisIocData/iocInfo/IOC.dbior")

# Let's get alarm ready Data
iocshCmd("dbl '' 'RTYP DTYP SCAN HHSV HSV LSV LLSV OSV ZSV HYST HIHI LOLO HIGH LOW' >/thisIocData/iocInfo/IOC.pvAlarm")

# Let's get input/output data
iocshCmd("dbl '' 'RTYP DTYP SCAN INP OUT OMSL DOL TSE' >/thisIocData/iocInfo/IOC.pvIO")

# Let's get scaling info
iocshCmd("dbl '' 'RTYP DTYP SCAN HOPR LOPR DRVH DRVL EGUF EGUL LINR AOFF ASLO ESLO' >/thisIocData/iocInfo/IOC.pvScale")

#Let's get the remaining interesting PV fields:
iocshCmd("dbl '' 'RTYP DTYP SCAN ASG IOVA IVOV ADEL MDEL SMOO' >/thisIocData/iocInfo/IOC.pvMisc")

# CA report
iocshCmd("casr(2) > /thisIocData/iocInfo/IOC.casr")

# Db CA Connections
iocshCmd("dbcar(0,1) > /thisIocData/iocInfo/IOC.dbcar")

# dbDumpRecord report
iocshCmd("dbDumpRecord > /thisIocData/iocInfo/IOC.dbDumpRecord")

# Post Startup Complete, the IRMIS crawler appreciates your cooperation.

# ======================================================================================================
# Set the Shell priority back:

rtems_task_set_priority(0, lcls_old_pri, &lcls_old_pri)
# ======================================================================================================



