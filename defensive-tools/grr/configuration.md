# Configure grr Server

## Update grr Agent Binaries with grr Server IP Address

1. SSH into the grr server

2. Edit `/etc/grr/server.local.yml`

    * Configure the URL at `AdminUI.url` with the IP address of the grr server

    * Configure the URL at `Client.server_urls` with the IP address of the grr server

    * `:%s/10.10.10.7/10.10.10.4/g`

3. Repack agent binaries

    ```bash
    grr_config_updater repack_clients
    ```

## Run grr Agent on Desired Machine

0. (DCI only) You may have to change your IP address to get on the same subnet as the grr server

    * IP address: 10.10.10.2

    * Default gateway: 10.10.10.1

1. Navigate to grr web interface from desired machine

    * http://$GRR_SERVER_IP:8000

2. Navigate to `Manage Binaries` > `executables` > `$OS` > `installers` and download an agent for the architecture of the desired machine

3. Execute the agent

4. Click the `search icon` and you should see your agent in the active agents pane
