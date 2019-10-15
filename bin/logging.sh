#!/bin/sh

# strip cis sequences
strip_cis () {
    # strip CUF
    sed -E 's/\[[0-9]*C//g' |
    # strip CUB
    sed -E 's/\[[0-9]*D//g' |
    # strip CUP
    sed -E 's/\[[0-9]?(;[0-9])?H//g' |
    # strip DECRST
    sed -E 's/\[\?[0-9]{1,4}l//g' |
    # strip DECSET
    sed -E 's/\[\?[0-9]{1,4}h//g' | 
    # strip EL
    sed -E 's/\[[0-2]?K//g' |
    # strip ED
    sed -E 's/\[[0-2]?J//g' |
    # strip SGR (ESC [ Pn m)
    sed -E 's/\[[0-9]{0,3}(:[0-9]{1,3}){0,4}(;[0-9]{1,3}){0,2}m//g' | 
    # strip escape sequence
    col -bpx
}

if [ "$(uname)" = 'Darwin' ]; then
    # Under OS X environment
    which gdate > /dev/null 2>&1
    if [ $? = 0 ];then
        # GNU date exists
    	date_command=gdate
    	date_arg=+'%Y %m %d_%H:%M:%S.%N'
    else
	# GNU date does not exist
    	date_command=date
    	date_arg=+'%Y %m %d_%H:%M:%S'
    fi
else
    # Under Linux environment
    date_command=date
    date_arg=+'%Y %m %d_%H:%M:%S.%N'
fi

while read -r LINE; do
    LINE=`echo ${LINE} | strip_cis`
    echo \[`${date_command} "${date_arg}"`\] ${LINE}
done

