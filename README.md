# Mirroring ocp versions for disconnected environments / connected with proxy

## Mirror process overview:
In order to succesfuly upgrade a fully restriced network or a semi restricted version (utilizng a proxy environment or a DMZ) you need to understand that pushing ocp upgrades you will need to include "step up" versions that are needed in between your base ocp version to your target ocp version.

For example if your base version is 4.8.39 and your target version is 4.10.18 you will need a "step up" version wich can be 4.9.33.
The upgrade process will look like this: "ocp v4.8.39 -> ocp v4.9.33 -> ocp v4.10.18"

1) **Base version** - What is your base version? (can be found with the following command)
  $ oc get clusterversion
2) **Architecture** - Can be one of the following (x86_64 / ppc64le / s390x)?
3) **Target version** - Choose your end target version? 
4) **Upgrade path** - As stated before sometimes when jumping between 'major' ocp versions you will need other 'major' version that will act as a "step up" version. In order to best know how to upgrade your environment use Redhat's "Upgrade Path" UI in the following link.
https://access.redhat.com/labs/ocpupgradegraph/update_path
**Important: Check the 'V' of _"Include hot fix versions"_ if you would like to include.**


## Pre-requisites:
1)  Bastion server with Rhel v8 or higher
2)  Installed on this bastion servers should be the following packeges & RPM's:
    - Podman
    - bash-completion (for convinience)
    - oc cli & kubectl from the following link (https://console.redhat.com/openshift/donwloads) **or**
      from here (https://access.redhat.com/downloads) 
3)  Pull secret from this page (https://console.redhat.com/openshift/install/pull-secret)  
4)  Have a registry container up and running - **for your convinience i've added a basic run command for one**
    - $ sudo mkdir -p /var/lib/registry
    - $ sudo podman run --privileged -d --name registry -p 5000:5000 -v /var/lib/registry:/var/lib/registry --restart=always registry:2
6)   Check for any other pre req from the "Updating a restricted network" page on Redhat link:
     (https://docs.openshift.com/container-platform/4.10/updating/updating-restricted-network-cluster.html)
**Check that the guide points to your desired ocp version _(At this moment the guide is pointing to version 4.10)_**
7)  Import script
8)  **Dont forget to add run permission to script with _chmod +x_
9)  Run script
10)  Compress the "mirror" dir from your _removable media path_ using tar or tgz. Example command for your use: $ tar -czvf <ocp_version>.tar.gz /<removable_media_path>
11) Import _mirrored_ version to your local registry using the command propted at the end of the _mirror_ process in the "connected" bastion server to your local ocp images registry.


## Using the script:
Using the script is straight forward:
1) Copy / Download the script and import to your _bastion_ machine.
2) Add _run_ option to the "script.sh" using: $ chmod +x "script.sh"
3) Input your variables values that are prompted from the script according to the questions stated in the _mirroring process overview_.
4) coppy the _mirror_ command for you internal registry that will "hold" the ocp images in your "disconnected" environment. 

## Feel free to submit a pull request or hit me up for any feedback & improvements!
