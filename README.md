
# Overview

Collection of scripts used to pull data from Netbox for various purposes 

<br>


## Get Tagged Device IP to File

#### <u>GetTaggedDeviceIPToFile.ps1</u>

Purpose of this script is to get a list of primary IP Addresses from Netbox which have a given tag. 

In my useage the text file output was being used for a External Dynamic List (EDL) for Palo Alto Firewalls to import.

- Gets list of dvices with specified tag

- Outputs a list of IP Addresses to a text file, one IP per line. 

<br>
<br>

## Get Tagged Subnets (Prefixes) for Palo Alto User ID Agent

#### <u>GetTaggedSubnetsForPaloAltoUserID.ps1</u>

Purpose of this script is to pull subnets (netbox refers to subnets as prefixes) and place them into the list of networks to include for Palo Alto's User ID Agent. 

- Gets list of subnets from netbox with specified tag
  - Script has two sets of tags as my usage included two different tags that I wished to logically seperate

- Updates the XML Configuration File for the Palo Alto User ID Agent to include only the subnets pulled from Netobox. 
