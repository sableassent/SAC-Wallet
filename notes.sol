Setup:

1. you need the address for the SAC1 token. this goes in the Escrowv2 and propv2 contracts as the token
2. you need the address for the DAO. This goes in the Escrowv2 contract as the contract Owner

once those 2 addresses are updated and input into the contracts.
deploy the IDNFT and stakeCert contracts:
1. input the deployed IDNFT contract address into the constructors of the propv2 contract 
2. input the deployed stakeCert contract address into the certificationNFTAddress of the propv2 contract

once these are done, you can start minting IDNFTs as well as Property NFTs
Then you can mint an AuthID for the DAO and for DAO representatives
The AuthIDs can mint propertyNFTs
The mint mintProperty function creates an escrow contract for each property that is minted
a user will need an IDNFT in order to stake 