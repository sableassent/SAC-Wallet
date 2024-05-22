// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract StakeCert is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    struct Certification {
        uint256 amountStaked;
        uint256 timestamp;
        address staker;
    }

    mapping(uint256 => Certification) public certifications;

    constructor() ERC721("Stake Cert", "SC") {}

    function mintCertification(address staker, uint256 amountStaked) external returns (uint256) {
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        _mint(staker, newItemId);
        
        Certification memory newCertification = Certification({
            amountStaked: amountStaked,
            timestamp: block.timestamp,
            staker: staker
        });

        certifications[newItemId] = newCertification;
        return newItemId;
    }
}
