# Use the official Telegraf image as the base
FROM telegraf:1.33@sha256:af3905668dd440044596ce09ed2bcf559e1830e4c5571e1a485acbf54830dd1a

# Took from https://github.com/golift/telegraf-docker/blob/main/Dockerfile
RUN apt update && apt install -y --no-install-recommends \
  sudo mtr-tiny lm-sensors smartmontools ipmitool nvme-cli && \
  rm -rf /var/lib/apt/lists/* && \
  echo 'telegraf ALL=NOPASSWD:/usr/sbin/smartctl *' | tee    /etc/sudoers.d/telegraf && \
  echo 'telegraf ALL=NOPASSWD:/usr/sbin/nvme *'     | tee -a /etc/sudoers.d/telegraf && \
  echo 'telegraf ALL=NOPASSWD:/usr/bin/ipmitool *'  | tee -a /etc/sudoers.d/telegraf && \
  echo "Done."

# Default command to start Telegraf
CMD ["telegraf"]

