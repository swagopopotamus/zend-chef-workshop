# Set up development environment with local chef repository
# ZendServer Cookbook from Zend Patterns github account

vagrant init
mkdir -p cookbooks/zendserver
cd cookbooks
git init
touch README
git add README
git commit -m "Initial commit so cookbooks can be added by knife."
wget --no-check-certificate https://github.com/zend-patterns/ZendServerChefCookbook/tarball/master
tar -xzf master

mv zend-patterns-ZendServerChefCookbook*/* zendserver/
rm -rf master zend-patterns-ZendServerChefCookbook*

# issue knife command from cookbooks directory to keep Windows drive letter
# designator from confusing the knife command -o option (since ":" is *nix
# path separator)
knife cookbook site install apt -o .
knife cookbook site install yum -o .

cd ..
