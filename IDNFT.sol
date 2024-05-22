// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract IDNFT is ERC721URIStorage, Ownable(msg.sender) {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    struct IDDetails {
        uint256 nftId;
        address owner;
        string docHash;
        address authorizer;
        string uri;
    }

    address[] public authorizers;
    uint256[] public keys; 
    mapping(uint256 => address[]) public IDs;
    mapping(uint256 => IDDetails) public idDetails;
    mapping(address => uint256) public ownerToID;
    mapping(address => bool) public authorized;

    event IDMinted(uint256 indexed nftId, address indexed owner, string docHash, address indexed authorizer, string uri);
    event AuthIDMinted(uint256 indexed nftId, address indexed owner, string docHash, address indexed authorizer, string uri);

    constructor() ERC721("IDNFT", "IDNFT") {
        authorized[msg.sender] = true;
    }

    modifier onlyID() {
        require(ownerToID[msg.sender] != 0, "No IDNFT found for this address");
        _;
    }

    modifier onlyAuthorizer() {
        require(isAuthorized(msg.sender), "Caller is not an authorizer");
        _;
    }

    function isAuthorized(address _caller) public view returns  (bool) {
        for (uint i = 0; i < authorizers.length; i++) {
            if (authorizers[i] == _caller) {
                return true;
            }
        }
        return false;
    }

    function hasID(address _caller) public view returns (bool) {
        for (uint256 i = 0; i < keys.length; i++) {
            address[] memory addresses = IDs[keys[i]];
            for (uint256 j = 0; j < addresses.length; j++) {
                if (addresses[j] == _caller) {
                    return true;
                }
            }
        }
        return false;
    }

    function mintID(address user, string memory docHash, string memory uri) external onlyAuthorizer {
        _tokenIds.increment();
        uint256 newID = _tokenIds.current();
        _mint(user, newID);
        _setTokenURI(newID, uri);

        idDetails[newID] = IDDetails({
            nftId: newID,
            owner: user,
            docHash: docHash,
            authorizer: msg.sender,
            uri: uri
        });

        ownerToID[user] = newID;

        emit IDMinted(newID, user, docHash, msg.sender, uri);
    }

    function mintAuthID(address user, string memory docHash, string memory uri) external onlyOwner {
        _tokenIds.increment();
        uint256 newID = _tokenIds.current();
        _mint(user, newID);
        _setTokenURI(newID, uri);

        idDetails[newID] = IDDetails({
            nftId: newID,
            owner: user,
            docHash: docHash,
            authorizer: msg.sender,
            uri: uri
        });

        ownerToID[user] = newID;
        authorized[user] = true;

        emit AuthIDMinted(newID, user, docHash, msg.sender, uri);
    }
}
