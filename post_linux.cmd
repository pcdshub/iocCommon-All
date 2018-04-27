#==============================================================
#
#  Abs:  Soft IOC post-startup initialization (Production)
#
#  Name: post_linux.cmd
#
#  Facility: PCDS Controls
#
#  Auth: 27-Jul-2009, Bruce Hill (bhill)
#  Rev:  dd-mmm-yyyy, Reviewer's Name (USERNAME)
#			Based on soft_post_st.cmd from LCLS
#--------------------------------------------------------------
#  Mod:
#       dd-mmm-yyyy, Firstname Lastname (USERNAME):
#         comment
#
#==============================================================
#
# Let's do some post startup things:
#
# Let's Get EPICS version:
iocshCmd("coreRelease > ${IOC_DATA}/${IOC}/iocInfo/IOC.epicsVersion")

# Let's Get EPICS environment:
iocshCmd("epicsEnvShow > ${IOC_DATA}/${IOC}/iocInfo/IOC.epicsEnvShow")

# Dump a list of all PVs to a file on the Boot Server:
# The pvs name will be written to a file along with its record type.
# The location on the boot server follows:
# ${IOC_DATA}/${IOC}/iocInfo
iocshCmd("dbl '' RTYP > ${IOC_DATA}/${IOC}/iocInfo/IOC.pvlist")
iocshCmd("dbl '' DTYP > ${IOC_DATA}/${IOC}/iocInfo/IOC.DTYP")

# Let's get the hardware info from the IOC to the boot server
iocshCmd("dbhcr > ${IOC_DATA}/${IOC}/iocInfo/IOC.dbhcr")
iocshCmd("dbior > ${IOC_DATA}/${IOC}/iocInfo/IOC.dbior")

# Let's get alarm ready Data
iocshCmd("dbl '' 'RTYP DTYP SCAN HHSV HSV LSV LLSV OSV ZSV HYST HIHI LOLO HIGH LOW' >${IOC_DATA}/${IOC}/iocInfo/IOC.pvAlarm")

# Let's get input/output data
iocshCmd("dbl '' 'RTYP DTYP SCAN INP OUT OMSL DOL TSE' >${IOC_DATA}/${IOC}/iocInfo/IOC.pvIO")

# Let's get scaling info
iocshCmd("dbl '' 'RTYP DTYP SCAN HOPR LOPR DRVH DRVL EGUF EGUL LINR AOFF ASLO ESLO' >${IOC_DATA}/${IOC}/iocInfo/IOC.pvScale")

#Let's get the remaining interesting PV fields:
iocshCmd("dbl '' 'RTYP DTYP SCAN ASG IOVA IVOV ADEL MDEL SMOO' >${IOC_DATA}/${IOC}/iocInfo/IOC.pvMisc")

# CA report
iocshCmd("casr(2) > ${IOC_DATA}/${IOC}/iocInfo/IOC.casr")

# Db CA Connections
iocshCmd("dbcar(0,1) > ${IOC_DATA}/${IOC}/iocInfo/IOC.dbcar")

# dbDumpRecord report
iocshCmd("dbDumpRecord > ${IOC_DATA}/${IOC}/iocInfo/IOC.dbDumpRecord")

# Post Startup Complete, the IRMIS crawler appreciates your cooperation.

