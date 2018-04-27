iocCommon=pathSubstitute("/nfsexport/iocCommon/%H")
nfsMount(getenv("NFS_FILE_SYSTEM"),iocCommon ,"/thisIocCommon")

< /thisIocCommon/startup.cmd


startupFile=pathSubstitute("/home/../%H/startup.cmd")
< startupFile
