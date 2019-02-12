# Gige Camera setup script

# Configure the network settings for optimum performance
# Using "ip link" command to derive primary ethernet adapter name
IP_NAME=`ip link | egrep mtu | head -2 | tail -1 | cut -d : -f 2`

# Enable jumbo packets
if  [ -n "$IP_NAME" ]; then
	ip link set $IP_NAME mtu 9000
fi

# Setup at least 2MB network receive buffers
sysctl -w net.core.rmem_default=2097152

