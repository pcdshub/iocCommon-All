# Gige Camera setup script

# Configure the network settings for optimum performance
# RHEL7 changed the names from ethX to enoX where en=Ethernet and o=Onboard
if [[ "`uname -r`" == *".el7."* ]]; then
	ifconfig eno1 mtu 9000
else
	ifconfig eth0 mtu 9000
fi

#sysctl -w net.core.rmem_default=1048576
sysctl -w net.core.rmem_default=2097152

# The following steps install a setuid gige executable,
# but require that the original be found in the current directory!
#if [ -x ./gige ];
#then
#	echo "Unable to find gige Executable in current directory!";
#	exit 1;
#fi

# Make sure we have a fresh copy of gige executable, owned by root
#mkdir -p /tmp/$IOC

# Remove old executable, if any
#rm -f /tmp/$IOC/gige

# Make a new setuid copy
#cp ./gige /tmp/$IOC/gige
#chmod a+rxs /tmp/$IOC/gige

