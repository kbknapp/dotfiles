#!/bin/bash

systemctl start openvpn@vypr-ca
ip route add 0.0.0.0/1 via 10.10.0.1 dev tun0