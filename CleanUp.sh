#!/bin/bash

while true; do
    echo "Available Resource Groups on Azure"
    az group list --output table
    read -p "Enter the name of the Azure resource group to delete (or 'done' to exit): " rg_name

    if [ "$rg_name" = "done" ]; then
        echo "Exiting cleanup script."
        break
    # Check if the resource group exists
    elif az group exists --name "$rg_name" &>/dev/null; then
        read -p "Are you sure you want to delete the '$rg_name' resource group? (y/n): " confirm
        if [ "$confirm" = "y" ]; then
            az group delete --name "$rg_name" --yes --no-wait
            echo "Deleting '$rg_name' resource group..."
        else
            echo "Resource group '$rg_name' will not be deleted."
        fi
    else
        echo "Resource group '$rg_name' not found."
    fi
done

while true; do
    echo "Status of Azure Resource Groups:"
    az group list --output table

    read -p "Type 'exit' to quit or press Enter to refresh the list: " user_input

    if [ "$user_input" = "exit" ]; then
        echo "Exiting the resource group list."
        break
    fi
done
