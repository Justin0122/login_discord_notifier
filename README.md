# device login discord notifier

### Only tested on Linux Manjaro Gnome

## Description

This script will send a message to a Discord channel when someone tries to login to your device and sends a (or multiple) pictures of the person trying to login using the webcam of your device. 

## Requirements

- Python 3.6 or higher
- OpenCV
- Discord Webhook

## Installation

1. Clone the repository
2. Install the requirements
3. Make the script executable
4. Change the gdm-password file
5. Change the webhook url in the script
6. Make some changes to the gdm-password file
7. Change the path to the script in the gdm-password file

```bash
auth     [success=1 default=ignore] pam_succeed_if.so user ingroup nopasswdlogin
auth     requisite                      pam_nologin.so
auth     optional                       pam_exec.so (path to the script)
auth/>
auth     required                       pam_unix.so try_first_pass likeauth nul>
auth     optional                       pam_permit.so
auth     optional                       pam_gnome_keyring.so

account  required                       pam_unix.so
account  optional                       pam_permit.so
account  optional                       pam_gnome_keyring.so

password required                       pam_unix.so try_first_pass use_authtok >
password optional                       pam_gnome_keyring.so use_authtok

session  required                       pam_limits.so
session  required                       pam_unix.so
session  optional                       pam_permit.so
session  optional                       pam_gnome_keyring.so auto_start
session  optional                       pam_systemd.so

```