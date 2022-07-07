# Network Mapping

> The process of enumerating an unknown network.

---

## Network Mapping Methodology

### 1. Router Enumeration

Determine the network's router(s). You can do this by either trusting the routers on an existing network map or, with access to the network, checking your default gateway and gateways to other networks.

With the routers in hand, ask permission to log in to them. For each router this is allowed on, use its **network interfaces** and **routing table** to add the router, its connected routers, and its connected subnetworks to the network map.

Next, for each router you have permission to log in to, use its **ARP cache** to determine hosts within its connected subnetworks. This likely won't cover all the hosts, but it will determine a lot of them.

### 2. Scanning: Host Discovery

First, perform a light ping sweep of all known subnets. Add all discovered hosts to their respective subnetworks in the network map.

Next, perform a TCP stealth scan (no ping) on the top 100 ports of each known subnet. Add any newly discovered hosts to their respective subnetworks in the network map.

### 3. Scanning: [[open-port-discovery|Open Port Discovery]] & [[open-port-enumeration|Enumeration]]

For each host discovered, perform an [[open-port-discovery|open port discovery]] scan on it.

With the ports discovered, do a more detailed [[open-port-enumeration|open port enumeration]] scan on *just* the hosts' open ports.
