// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/interfaces/IERC20.sol";
import "./Cert.sol";
import "./IDNFT.sol";
import "./Staking.sol";

contract Escrowv2 is IStaking {
    address _tokenAddress = 0xbFB179D21A082cBb30ff245b6bCAb8a5b5566bAa;
    address private contractOwner = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    address public assetOwner;
    IERC20 private token;
    StakeCert private certification;
    IDNFT private idnft;

    uint256 public propValue;
    uint256 private withdrawn;

    mapping(address => uint256) public stakedAmounts;
    mapping(address => uint256) public stakingStarts;
    //add a mapping for specific staking certification

    constructor(address _assetOwner, address _certificationAddress, address _idnftAddress, uint256 _propValue) {
        contractOwner = msg.sender;
        assetOwner = _assetOwner;
        token = IERC20(_tokenAddress);
        idnft = IDNFT(_idnftAddress);
        certification = StakeCert(_certificationAddress);
        propValue = _propValue;
        withdrawn = 0;
    }

    modifier onlyOwners() {
        require(msg.sender == assetOwner || msg.sender == contractOwner, "Not authorized");
        _;
    }

   modifier onlyID() {
        require(idnft.hasID(msg.sender), "Caller is not an authorizer");
        _;
   }

    // Function to return the total amount of IERC20 tokens staked in the contract
    function totalStakedTokens() external view returns (uint256) {
        return token.balanceOf(address(this));
    }

    function stake(uint256 amount) external payable {
        require(token.transferFrom(msg.sender, address(this), amount), "Transfer failed");
        stakedAmounts[msg.sender] += amount;
        stakingStarts[msg.sender] = block.timestamp;
        certification.mintCertification(msg.sender, amount);

        emit TokensStaked(msg.sender, amount);
    }

    function withdraw(uint256 amount) external {
       uint256 maxWithdrawable = (propValue * 80) / 100;
        uint256 newWithdrawn = withdrawn + amount;
        if (msg.sender == assetOwner) {
            require(newWithdrawn <= maxWithdrawable, "Exceeds max withdrawable amount");
        }
        withdrawn = newWithdrawn;
        require(token.transfer(msg.sender, amount), "Transfer failed");
    }

     function claimRewards() external override {
        uint256 rewards = calculateRewards(msg.sender);
        require(token.transfer(msg.sender, rewards), "Token transfer failed");
        emit RewardsClaimed(msg.sender, rewards);
    }

    // This function returns the staked amount and calculated rewards for a user
    function getStakeInfo(address staker) external view override returns (uint256, uint256) {
        return (stakedAmounts[staker], calculateRewards(staker));
    }

    //Internal function to calculate rewards based on the staked duration and amount
    function calculateRewards(address staker) internal view returns (uint256) {
        uint256 stakingPeriod = block.timestamp - stakingStarts[staker];
        uint256 rewardRate;

        if (stakingPeriod >= 7776000 && stakingPeriod < 12960000) { // 3 to 5 months
            rewardRate = 103;
        } else if (stakingPeriod >= 12960000 && stakingPeriod < 18144000) { // 5 to 7 months
            rewardRate = 104;
        } else if (stakingPeriod >= 18144000 && stakingPeriod < 23328000) { // 7 to 9 months
            rewardRate = 105;
        } else if (stakingPeriod >= 23328000 && stakingPeriod < 31104000) { // 9 to 12 months
            rewardRate = 106;
        } else if (stakingPeriod >= 31104000) { // More than 12 months
            rewardRate = 107;
        } else {
            rewardRate = 0; // No rewards for staking periods under 3 months
        }

        return (stakedAmounts[staker] * rewardRate) / 100;
    }


}