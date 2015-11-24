# NAME: test-chef.sh
# AUTHOR: Joaquin Menchaca
# CREATED: 2015-11-23
#
# PURPOSE: Demo "Hello World" style recipe to test workflow and application of
#  Chef recipe from the Chef Server with knide.  Thus this is sort of like a
#  smokescreen test to test the functionality of the system.
# DEPENDENCIES:
#  * Provisioned Chef Server, Workstation, and Node systems
# NOTES:
#  * This script will be run on guest workstation: `vagrant ssh work`
#  * Note: `knife bootstrap` installs old version of Chef Client, e.g. 11.8.2.
#      For this simple test, this does not cause a problem.
#      Advanced recipes need to install a later version of chef client.
cd ~/chef-repo

#### STEP 1: GENERATE COOKBOOK
chef generate cookbook cookbooks/hello_chef_server

#### STEP 2: CREATE THE CHEF RECIPE
cat <<-RECIPE_EOF > $HOME/chef-repo/cookbooks/hello_chef_server/recipes/default.rb

file "#{Chef::Config[:file_cache_path]}/hello.txt" do
  content 'Hello, Chef server!'
end

RECIPE_EOF

#### STEP 3: UPLOAD THE CHEF RECIPE TO CHEF SERVER UNDER VAGRANTDEV ORG
knife cookbook upload hello_chef_server

#### STEP 4: VERIFY THE CHEF RECIPE IN VAGRANTDEV ORG
knife cookbook list

#### STEP 5: BOOTSTRAP A NODE USING RECIPE
ADDRESS="node"
NODE_NAME=${ADDRESS}
USER="vagrant"
RUN_LIST='recipe[hello_chef_server]'

knife bootstrap ${ADDRESS} --sudo --ssh-user ${USER} --node-name ${NODE_NAME} --run-list ${RUN_LIST}
