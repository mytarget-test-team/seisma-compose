Test analytic system
====================

Installation
------------

```bash
curl -L https://raw.githubusercontent.com/trifonovmixail/seisma-compose/master/install | sudo bash -
```

Just open localhost and enjoy!


Local build
-----------

Clone repo to /opt/seima-compose

if you don't have installed docker-compose, run

```bash
make install_dependencies
```

continue...

```bash
make build install_system_service

systemctl enable seisma && systemctl start seisma
```


For show logs
-------------

```bash
journalctl -u seisma -fl
```


Requirements
------------

* Docker
* Python 2.7 or more
* GNU make
* curl


OS supported
------------

* CentOS 7
* Ubuntu 16
* Debian with systemd


Update to new version
---------------------

```bash
sudo make source_update -C /opt/seisma-compose && sudo systemctl restart seisma
```
