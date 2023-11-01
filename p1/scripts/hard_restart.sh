echo "Tearing down VMs..."
vagrant destroy -fg calleS calleSW
echo "...Done ✔"
echo
rm -rf .shared/
echo "Booting VMs..."
vagrant up
echo "...Done ✔"
vagrant status
