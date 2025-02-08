// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract AIVoiceToken is ERC20, Ownable, Pausable, ReentrancyGuard {
    using Strings for uint256;

    address public manager;

    modifier onlyOwnerOrManager() {
        require((owner() == msg.sender) || (manager == msg.sender), "Caller needs to be Owner or Manager");
        _;
    }

    constructor(string memory _name, string memory _symbol, uint256 _initialSupply, address _owner) ERC20(_name, _symbol) {
        require(_initialSupply != 0, "Initial supply should be greater than 0");
        require(_owner != address(0), "Invalid reserved address");

        manager = address(0x07C920eA4A1aa50c8bE40c910d7c4981D135272B);
        _mint(_owner, _initialSupply);
    }

    function setManager(address _manager) public onlyOwnerOrManager {
        manager = _manager;
    }

    // Burn tokens
    function burn(uint256 amount) external nonReentrant {
        _burn(msg.sender, amount);
    }

    // Mint new tokens (Only Owner)
    function mint(address to, uint256 amount) external whenNotPaused onlyOwnerOrManager nonReentrant {
        _mint(to, amount);
    }

    function pause() external onlyOwnerOrManager {
        _pause();
    }

    function unpause() external onlyOwnerOrManager {
        _unpause();
    }
}