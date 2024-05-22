// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.11;

interface IStaking {
    event TokensStaked(address indexed staker, uint256 amount);
    event TokensWithdrawn(address indexed staker, uint256 amount);
    event RewardsClaimed(address indexed staker, uint256 rewardAmount);

    function stake(uint256 amount) external payable;
    function withdraw(uint256 amount) external;
    function claimRewards() external;
    function getStakeInfo(address staker) external view returns (uint256 _tokensStaked, uint256 _rewards);
}
