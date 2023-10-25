#!/bin/bash

#check if resource group already exists.
check_resource_group () {
    while true; do
        read -p "Enter name for your new Resource Group : " resource_group
        if [ $(az group exists --name $resource_group) == true ]; then
            echo "Resource Group $resource_group already exists, provide another name."
        else
            break
        fi
    done  
}

show_regions () {
    echo Showing Azure datacentre regions in Europe...
    az account list-locations --query "[?contains(regionalDisplayName, 'Europe')]" --output table
}

create_resource_group () {
# Get a list of Azure datacenter regions and store it in a variable
regions=$(az account list-locations --query '[].name' --output tsv)

# Check if the user's input is in the list of Azure datacenter regions
valid_location=fales
until [ "$valid_location" == true ]; do
    read -p "Which region would you like to create your Resource Group $resource_group in? : " resource_region
    if [[ $regions == *"$resource_region"* ]]; then
        valid_location=true
        echo "Creating Resource Group $resource_group in $resource_region..."
        az group create --name $resource_group --location $resource_region
    else
        echo "$resource_region is not a valid Azure datacenter region."
    fi
done
}

#display available Resource Group
display_resource_groups () {
    echo Your current available Resource Groups..
    az group list -o table
}

#display available VM images
display_vm_images () {
    echo "Displaying latest VM images available..."
    az vm image list --query '[].{URNAlias:urnAlias, Version:version}' --output table
    read -p "Which VM image would you like to use? : " vm_image
}

#create VM on Azure
create_vm () {
    read -p "Enter computer name for VM : " vm_name
    read -p "Enter user name for $vm_name : " usr_name
    az vm create --resource-group $resource_group --name $vm_name --admin-user $usr_name --image $vm_image --generate-ssh-keys
}

#display VM
display_vm () {
    echo Available VM on Azure
    az vm list -o table
}

connect_to_vm () {
    publicIP=$(az vm show --show-details --resource-group $resource_group --name $vm_name --query publicIps --output tsv)
    #connect to VM
    ssh $usr_name@$publicIP
}

open_port () {
    while true; do
        read -p "Do you want to allow web traffic for $vm_name? (y/n): " confirm
        if [ "$confirm" = "y" ]; then
            az vm open-port --port 80 --resource-group $resource_group --name $vm_name
            echo "You can now access website @ http://$publicIP/Hello.html"
            break
        elif [ "$confirm" = "n" ]; then
            echo "Script Completed"
            break
        else
            echo "Invalid input"
        fi
    done
}

display_resource_groups
check_resource_group
show_regions
create_resource_group
display_resource_groups
display_vm_images
create_vm
display_vm
connect_to_vm
open_port