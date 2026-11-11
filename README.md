# Proton VPN 5-Minute IP Rotator

A robust Windows batch automation script designed to automatically cycle and rotate your Proton VPN IP address every 5 minutes using the official desktop client.

## Features

* **Dynamic Binary Detection:** Automatically scans Windows Registry hives and standard installation directories to locate `ProtonVPN.exe` instantly.
* **Clean Process Flushing:** Forcefully terminates active VPN service instances, OpenVPN, and WireGuard tunnels to prevent adapter lockups.
* **Automated Loop:** Continuously reconnects to a random free-tier server every 300 seconds.

## Prerequisites & Dependencies

1. **Operating System:** Windows 10 or Windows 11.
2. **VPN Client:** Download and install the official desktop application from the [Proton VPN Official Download Page](https://protonvpn.com/download).

## Installation & Usage

1. Download or clone this repository to your local machine.
2. Ensure the Proton VPN application is installed on your system.
3. Right-click `rotator.bat` and select **Run as administrator** (administrator privileges are required to manage network adapters and terminate background services).
4. Leave the command prompt window open in the background to maintain the rotation loop. Press `Ctrl + C` to terminate the script at any time.

## Disclaimer
This tool is built for educational and automation testing purposes. Ensure your usage complies with Proton VPN's terms of service.
