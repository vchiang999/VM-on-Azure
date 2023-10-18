#!/bin/bash

#check if resource group already exists.
check_resource_group () {
    while true; do
        read -p "Enter name for your Resource Group" resource_group
        if [ $(az group exists --name $resource_group) = true ]; then
            echo "Resource Group $resouce_group already exists"
        else
            break
        fi
    done    
}

#create the Resource Group
create_resource_group () {

}

check_resource_group

#read -p "Enter name for VM" vm_name
#read -p "Enter user name for VM" usr_name
#read -p "Choose a region" region
