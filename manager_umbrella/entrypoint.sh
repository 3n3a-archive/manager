#!/bin/bash

# Migrate DB
echo "Migrating..."
/app/bin/manager_umbrella eval "ManagerWeb.Release.migrate"

# Start Apps
echo "Starting..."
/app/bin/manager_umbrella start