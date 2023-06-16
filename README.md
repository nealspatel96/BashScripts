# BashScripts

BashLib (include files for other bash scripts):

Monitor.sh
- defines the monitor function that can continuously show output in real time in a loop without causing the output terminal to flicker
- manipulate the cursor positioning instead of running a command in a loop and using clear

Colors.sh
- constants for printing in color when using "echo -e" or "printf"


# BashScripts (runnable scripts) 

DateTimeMonitor.sh (Windows/Linux)
- shows output of current time based on current timezone, utc time, or time since epoch in seconds using the monitor function in Monitor.sh

GenerateRsakeys.sh (Windows/Linux)
- used to generate ssh keys using the ssh-keygen command

GitConfigSetup.sh  (Windows/Linux)
- used for setting up default configuration in the .gitconfig file

ShowHostInfo.sh  (Windows/Linux)
- shows important info about your pc: CPU, memory, network, disk space, env variables, processes, etc.

wttr.in.sh  (Windows/Linux)
- script runs curl command to show output from wttr.in web api from @igor_chubin
- outputs moon stats and weather based on location (current location may be different if VPN is running) 