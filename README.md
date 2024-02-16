# Hyperledger fabric production grade

This is a production grade blockchain setup without docker swarm and using real domain on every node.

It has following things-

- 1 CA
- 1 raft orderer
- 2 peers
- 2 organizations
- 1 channel


## Deployment

To deploy the blockchain on machine 1

```bash
cd scripts
sudo ./runCA.sh <caname> admin adminpw ../yamls/ ca.yaml
sudo ./generateCryptos.sh (for fresh installation)
sudo ./createGenesisBlock.sh (for fresh installation)
sudo ./runDockerContainer.sh ../yamls/orderer.yaml
sudo ./runDockerContainer.sh ../yamls/peer0.org1.yaml
sudo ./createAndJoinChannel.sh <channelname>
sudo chmod -R a+wrx <rootfolder>
sudo apt install jq (first time only)
sudo ./updateAnchorPeerForChannelOnOrg1.sh <channelname>
```
To deploy the blockchain on machine 2
```bash
- copy the crypto folder to machine 2
- sudo chmod -R a+wrx <rootfolder>
- sudo ./runDockerContainer.sh ../yamls/peer0.org2.yaml
- sudo ./joinChannelByOrg2.sh <channelname>
- sudo apt install jq (first time only)
- sudo ./updateAnchorPeerForChannelOnOrg2.sh <channelname>
```
### Modification

Somethings are still hardcoded into the scripts.I'll update that once i'll get time.But for now you have to follow the following-

- open the root folder using vs code
- replace all **ibrahim.com,khalil.com** with your two domains
- replace **caibrahim** with your <caname>
- then follow the deployment steps.

#### Chaincode Deployment

To deploy the chaincode you have to execute the chaincodeInstall.sh file under scripts folder.The chaincode it would install is a basic asset chaincode.But if you want to install a custom chaincode then you have to modify the values of export.
