# set up workshop scenario 1 - Development Environment w/ single Zend Server

PROVISIONING_SCRIPTS_DIR=~/repos/Provisioning-With-Chef/Provisioning-With-Chef
WORKSHOP_DIR=~/Documents/vagrant-vms/workshop-scenario-1

echo Creating $WORKSHOP_DIR
mkdir $WORKSHOP_DIR
cd $WORKSHOP_DIR

echo Preparing directory with Vagrant, Chef Cookbooks
. ${PROVISIONING_SCRIPTS_DIR}/setup-chef-repo-dev-github.sh

echo Copying Vagrantfile
cp ${PROVISIONING_SCRIPTS_DIR}/Vagrantfile ${WORKSHOP_DIR}/Vagrantfile

echo Starting and provisioning the VM
vagrant up
