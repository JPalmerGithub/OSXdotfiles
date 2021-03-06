#!/bin/bash

# Variables
user=$(whoami)
hostname=$(hostname | sed 's/.local//g')
distro="OS X $(sw_vers -productVersion)"
kernel=$(uname)
uptime=$(uptime | sed 's/.*up \([^,]*\), .*/\1/')
shell="$SHELL"
terminal="$TERM"
packages="`brew list -l | wc -l | awk '{print $1 }'`"
cpu=$(sysctl -n machdep.cpu.brand_string)
mem=$(sysctl -n hw.memsize)
ram="$((mem/1000000000)) GB"
disk=`df | head -2 | tail -1 | awk '{print $5}'`

echo "

                    ###
                   ####             User: $user 
                   ###              Hostname: $hostname 
          ########     #######      Distro: $distro 
         ######################     Kernel: $kernel 
        #####################       Uptime: $uptime 
        ####################        Shell: $shell 
        ####################        Terminal: $terminal 
        #####################       Brew Packages: $packages 
         ######################     CPU: $cpu 
          ####################      Memory: $ram 
            ################        Disk: $disk 
               #### ##### 
"