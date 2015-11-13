# TEST CHEF SCRIPT
#  This is a demonstration script to show the work flow and healthy interaction
#  NOTE: RUN THIS UNDER VAGRANT ACCOUNT
#

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
