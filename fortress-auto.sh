#!/bin/bash
wget "https://dl.walletbuilders.com/download?customer=f830b234dde6317ad57bf35703eb5f9c8fc26adf6727a569c8&filename=fortress-qt-linux.tar.gz" -O fortress-qt-linux.tar.gz

mkdir $HOME/Desktop/Fortress

tar -xzvf fortress-qt-linux.tar.gz --directory $HOME/Desktop/Fortress

mkdir $HOME/.fortress

cat << EOF > $HOME/.fortress/fortress.conf
rpcuser=rpc_fortress
rpcpassword=dR2oBQ3K1zYMZQtJFZeAerhWxaJ5Lqeq9J2
rpcbind=0.0.0.0
rpcallowip=127.0.0.1
listen=1
server=1
addnode=node2.walletbuilders.com
EOF

cat << EOF > $HOME/Desktop/Fortress/start_wallet.sh
#!/bin/bash
SCRIPT_PATH=\`pwd\`;
cd \$SCRIPT_PATH
./fortress-qt
EOF

chmod +x $HOME/Desktop/Fortress/start_wallet.sh

cat << EOF > $HOME/Desktop/Fortress/mine.sh
#!/bin/bash
SCRIPT_PATH=\`pwd\`;
cd \$SCRIPT_PATH
echo Press [CTRL+C] to stop mining.
while :
do
./fortress-cli generatetoaddress 1 \$(./fortress-cli getnewaddress)
done
EOF

chmod +x $HOME/Desktop/Fortress/mine.sh

exec $HOME/Desktop/Fortress/fortress-qt &

sleep 15

cd $HOME/Desktop/Fortress/

clear

exec $HOME/Desktop/Fortress/mine.sh