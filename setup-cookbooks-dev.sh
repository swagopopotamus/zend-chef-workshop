# Run this in the same directory as the Vagrantfile

# Get ZendServerChefCookbook from Chef Community Site
#### staying in this directory gets around Windows drive letter designator confusing knife command -o option (":" is *nix path separator) ####
knife cookbook site install zendserver -o .

#### cd to get around Windows drive letter designator confusing knife command -o option (":" is *nix path separator) ####
# If ZendServerChefCookbook from Chef Community Site, then change to cookbooks directory is needed
#cd cookbooks
#knife cookbook site install apt -o .
#knife cookbook site install yum -o .

cd $DIR_ORIG
