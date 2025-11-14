#!/bin/bash

echo "===→ Starting system maintenance ←==="

echo "STEP 1: Attempting to create safety snapshot..."

if ! sudo timeshift --create --tags O --comment "Weekly update $(date +%Y-%m-%d)"; then
    
    echo "CRITICAL FAILURE: Timeshift snapshot failed!"
    echo "Updates stopped! See error above."
    
else
    
    echo "STEP 1 SUCCESS: Snapshot created. Proceeding to updates..."
    
    echo "STEP 2: Refreshing package lists..."
    sudo apt update
    
    echo "STEP 3: Upgrading system packages..."
    sudo apt upgrade -y
    
    echo "STEP 4: Updating Flatpaks..."
    flatpak update -y
    
fi

echo "STEP 5: Running cleanup tasks..."

sudo apt autoremove -y ;
sudo apt clean ;
flatpak uninstall --unused -y ;

echo "===→ System maintenance finished ←==="
