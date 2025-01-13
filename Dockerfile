# Use the official Telegraf image as the base
FROM telegraf:latest

# Switch to root to install dependencies
USER root

# Update package lists and install required tools
RUN apt update && apt install -y \
    smartmontools \
    lm-sensors \
    nvme-cli \
    ipmitool \
 && apt-get update \
 && apt-get install -y sudo \
 && apt clean \
 && rm -rf /var/lib/apt/lists/*

# Modify the sudoers file to allow the telegraf user to run smartctl and nvme without a password
RUN echo 'Cmnd_Alias SMARTCTL = /usr/sbin/smartctl' >> /etc/sudoers && \
  echo 'Cmnd_Alias NVME = /usr/sbin/nvme' >> /etc/sudoers && \
  echo 'telegraf  ALL=(ALL) NOPASSWD: SMARTCTL, NVME' >> /etc/sudoers && \
  echo 'Defaults!SMARTCTL !logfile, !syslog, !pam_session' >> /etc/sudoers && \
  echo 'Defaults!NVME !logfile, !syslog, !pam_session' >> /etc/sudoers

# Switch back to the Telegraf user for running the container
USER telegraf

# Default command to start Telegraf
CMD ["telegraf"]

