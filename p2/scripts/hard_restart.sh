echo "Tearing down VMs..."
vagrant destroy -fg calleS
echo "...Done ✔"
echo
echo "Booting VMs..."
vagrant up
echo "...Done ✔"
echo
vagrant status
