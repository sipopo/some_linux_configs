
#
# Add some my custom configs for bash
#

umask 027
echo "Prepare some dirs"
MY_CONF=~/.my_configs
MY_TMP=~/.my_tmp
[ -d "${MY_CONF}" ] || mkdir ${MY_CONF}
[ -d "${MY_TMP}" ] || mkdir ${MY_TMP}

echo "Run ssh-agent"
socket_file=${MY_TMP}/ssh-agent.socket
agent_config=${MY_CONF}/ssh-agent.config

[ -f ${agent_config} ] || ssh-agent -a ${socket_file} > ${agent_config}
source ${agent_config}

# check running ssh-agent 
ps -p ${SSH_AGENT_PID} >/dev/null
[ $? -eq 0 ] || ( ssh-agent -a ${socket_file} > ${agent_config} && source ${agent_config} )  
