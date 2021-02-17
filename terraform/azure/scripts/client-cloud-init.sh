#!/bin/bash
echo "DNS=1.1.1.1 1.0.0.1" >> /etc/systemd/resolved.conf
echo "Domains=~." >> /etc/systemd/resolved.conf
systemctl restart systemd-resolved