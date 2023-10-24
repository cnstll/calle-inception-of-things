echo "Tearing down VMs..."
vagrant destroy -fg calleS calleSW
echo "...Done"
echo
echo "Booting VMs..."
vagrant up
echo "...Done"
vagrant status