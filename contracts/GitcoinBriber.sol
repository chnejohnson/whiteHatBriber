//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// Idea: A briber wants bribees to contribute to a Gitcoin Grant project.

contract GitcoinBriber is ERC20 {
    uint256 public startTime;
    uint256 public endTime;
    address payable public project;

    constructor(
        uint256 _startTime,
        uint256 _endTime,
        address payable _project
    ) ERC20("AirDrop Token", "ADT") {
        startTime = _startTime;
        endTime = _endTime;
        project = _project;
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

    function acceptBribe() public payable {
        (bool sent, bytes memory data) = project.call{value: msg.value}("");
        require(sent, "GitcoinBriber: Failed to send Ether");

        sendReward(msg.sender, msg.value);
    }
}
