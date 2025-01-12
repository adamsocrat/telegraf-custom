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
 && apt clean \
 && rm -rf /var/lib/apt/lists/*

# Switch back to the Telegraf user for running the container
USER telegraf

# Default command to start Telegraf
CMD ["telegraf"]

