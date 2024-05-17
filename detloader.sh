#!/bin/bash


SCRIPT_URL="https://raw.githubusercontent.com/tristanlucas/lnxpointer/main/lnxpoint"
SERVICE_URL="https://raw.githubusercontent.com/tristanlucas/lnxpointer/main/dbai.service"
SCRIPT_PATH="/usr/bin/lnxpoint"
SERVICE_PATH="/etc/systemd/system/dbai.service"

echo "Fetching the loader..."
if curl -o $SCRIPT_PATH $SCRIPT_URL; then
    echo "Loader fetched successfully."
    chmod +x $SCRIPT_PATH
else
    echo "Failed to fetched the loader from $SCRIPT_URL"
    exit 1
fi

echo "Fetching the service..."
if curl -o $SERVICE_PATH $SERVICE_URL; then
    echo "Service fetched successfully."
else
    echo "Failed to fetch the service from $SERVICE_URL"
    exit 1
fi

echo "Reloading systemd daemon..."
sudo systemctl daemon-reload

echo "Enabling and starting the DET loader service..."
sudo systemctl enable dbai.service
sudo systemctl start dbai.service

systemctl status dbai.service

echo "Installation complete. dbai.service is now installed and running as a service."


