# SAC Wallet Software Specification

# 1. Purpose

The goal of this project is to provide the world’s first black empowerment crypto token to be used in business, non-profits, and within black families everywhere. We call it Sable Assent Coin, shown as “SAC1” on the exchanges.

# 2. Scope 

We are a digital currency platform that embraces and supports the economic systems of the black community. Sable Assent Coin can be utilized by logging into the web wallet dashboard. This wallet dashboard interface can be used on all devices through the web interface as it will host our decentralized mobile wallet application available for both iOS as well as Android devices.

# 3. Product Perspective: System Interfaces

Public SAC1 users can use a third party wallet to transact SAC1 minted coins. Private SAC2 token requires the use of our custom wallet (SAC Wallet) to make transactions within our private blockchain node network we call the SableNet. This decentralized network is made up of nodes owned and administered by Token Ambassadors. They sign transactions on the SableNet using the Proof-of-Authority (POA) mining protocol.

The SAC Wallet allows users access to the public coins listed on reputable exchanges, and importantly the ability to trade coins and tokens within the wallet to gain access to our private marketplace of business vendors.

The blockchain network would be a private consortium of nodes located with our Token Ambassadors around the world. The Token Ambassador will have to be verified in order to purchase their own prefabricated node. Nodes achieve consensus by connecting to a central node validation server administered by the Sable Assent Corporation. 

# Our structure will look something like this

Public SAC1 Coin:
[Mobile Wallet (end user)] <==> [API Server (web hooks/html <==> Infura API<==> ethereum client)] <==> [Ethereum Network (solidity smart-contract)]

Private SAC2 Token:

[Mobile Wallet (end user)] <==> [API Server (web3 <==> SAC API<==> web hooks/html)]<==> [Private Ethereum Network (Token Ambassador Nodes) <= = > (web application/javascript)<==>solidity code<==> ethereum client)] <==> [ Master Node (web application/javascript)<==>(ethereum client) ]



## Getting Started

This application currently operates using our api you can see and test on postman here: [SAC-ERC20Token-API]version=latest)

The API communicates with our Smart Contract:
PRESENT PUBLIC SMART CONTRACT:
Token Contract: 0x3e27A81e83567aD1A24ae67dEec3dAda8ce2c3ec on www.etherscan.io

-------------------------------------------------------------------------
The software development team will have private access to this github project workspace. The most stable version of the code is on the Master branch. Each team member will have access to the codebase on the github cloud. Each developer will be assigned their own branch and must create a github workspace directory on their own local devices.




A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
