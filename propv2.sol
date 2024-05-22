// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "./Escrowv2.sol";


contract PropertyNFT is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    address private idnftAddress;
    address private tokenAddress = 0xbFB179D21A082cBb30ff245b6bCAb8a5b5566bAa;
    address private certificationNFTAddress = 0xA6D26090a198B63Dc29712370F2f66ACfffdaEF1;
    IDNFT private idnft;

    struct Property {
        address assetOwner;
        address escrowAddress;
        uint256 propertyValue;
        string docsHash;
        string uri;
    }

    mapping(uint256 => Property) public properties;

    
    constructor(address _idnftAddress) ERC721("PropertyNFT", "PNFT") {
  
       idnftAddress = _idnftAddress;
       idnft = IDNFT(_idnftAddress);
    }

    modifier isAuthorized() {
        require(idnft.isAuthorized(msg.sender), "Not an authorized minter");
        _;
    }

    function mintProperty(
        address assetOwner,
        uint256 propertyValue,
        string memory docsHash,
        string memory uri

    ) external returns (uint256) {
        _tokenIds.increment();
        uint256 newPropertyId = _tokenIds.current();
        _mint(assetOwner, newPropertyId);
        _setTokenURI(newPropertyId, uri);

        Escrowv2 newEscrow = new Escrowv2(assetOwner, certificationNFTAddress, idnftAddress, propertyValue);
        properties[newPropertyId] = Property({
            assetOwner: assetOwner,
            escrowAddress: address(newEscrow),
            propertyValue: propertyValue,
            docsHash: docsHash,
            uri: uri
        });

        return newPropertyId;
    }
}
