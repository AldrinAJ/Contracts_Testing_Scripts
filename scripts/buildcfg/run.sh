#cd /app/Contracts_Testing_Scripts/results/cfgs/research/
cd ~
slither $1 --print cfg
sudo cp *.dot /app/Contracts_Testing_Scripts/results/cfgs/research/
rm *.dot
