# Configure SecurityOnion Server/Sensor Architecture
The following configuration is for the DCI course specifically.

## Configure the server

1. Click the `Setup` icon on the Desktop

2. When it asks whether you'd like to skip network configuration, click `Yes, I'd like to skip network configuration!`

3. Evaluation or Production Mode? Select `Production Mode`

4. Choose `Server`

5. Best Practices or Custom? Select `Custom`

6. Choose sguil username and password

7. How many days of data do you want to keep in your Sguil database? `Default`

8. How many days of data do you want to repair in your Sguil database? `Default`

9. Which IDS engine would you like to use? `Snort` (DCI only)

10. Which IDS ruleset would you like to use? `Emerging Threats Open`

11. Enable `Salt`? `Yes, enable Salt!`

12. Enable `ELSA`? `Yes enable ELSA!`

13. How much disk space should be allocated for ELSA to store logs? `Default`

14. `Yes, proceed with the changes!`

## Configure server firewall to interact with sensor

```bash
sudo so-allow
s
$IP_ADDRESS_OF_SENSOR
[ENTER]
```

## Configure the sensor

1. Click the `Setup` icon on the Desktop

2. When it asks whether you'd like to skip network configuration, click `Yes, I'd like to skip network configuration!`

3. Evaluation or Production Mode? Select `Production Mode`

4. Choose `Sensor`

5. Enter IP address of SecurityOnion server

6. Enter the username of the user on the server with sudo privileges

7. Best Practices or Custom? Select `Best Practices`

8. PF-RING buffer? `Default`

9. Which network interface(s) should be monitored? Choose the listening interface (`eth1` for DCI)

10. What would you like to configure HOME_NET as? `Default`

11. Would you like to automatically update the ELSA server? `No, do not update the ELSA server`

12. `Yes, proceed with the changes!`

13. Keep an eye on the terminal during the process. You will be repeatedly prompted for the password of the username you specified in #6.

## Disable checksum mode on sensor so we can use raw PCAPs (DCI only)

On the sensor and in `/etc/nsm/$SENSOR_HOSTNAME-$LISTENING_INTERFACE/snort.conf`, replace the line

```text
config checksum_mode: all
```

with

```text
config checksum_mode: none
```

## Add Snort rules to server

Add rules to `/etc/nsm/rules/local.rules`, one rule per line (on the server only)

## Check rule syntax

```bash
sudo snort -Tc /etc/nsm/rules/local.rules
```

## Update Snort rules (server)

```bash
sudo rule-update
```

## Update Snort rules (sensor)

```bash
sudo rule-update
```

## Open sguil interface on server

1. Click `sguil` icon on Desktop

2. Select sensor

## Replay PCAP on sensor

```bash
sudo tcpreplay -i $LISTENING_INTERFACE -M10 $PCAP
```
