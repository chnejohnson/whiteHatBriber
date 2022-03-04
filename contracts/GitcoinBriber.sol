//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// Idea: A briber wants bribees to contribute to a Gitcoin Grant project.

contract GitcoinBriber is ERC20 {
    uint256 public startTime;
    uint256 public endTime;

    constructor(uint256 _startTime, uint256 _endTime)
        ERC20("AirDrop Token", "ADT")
    {
        startTime = _startTime;
        endTime = _endTime;
    }

    modifier isBribingPeriod() {
        require(
            block.timestamp > startTime && block.timestamp < endTime,
            "GitcoinBriber: Not at the bribing period."
        );
        _;
    }

    function sendReward(address recipient, uint256 amount) public {
        _mint(recipient, amount);
    }

    function acceptBribe() public {}
}
