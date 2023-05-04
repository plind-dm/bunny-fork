// SPDX-License-Identifier: MIT
pragma solidity ^0.6.12;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/SafeERC20.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";

import "../library/SafeToken.sol";
import "../interfaces/IWETH.sol";

contract safeSwapBNB {
    using SafeERC20 for IERC20;
    using SafeMath for uint256;

    /* ========== CONSTANTS ============= */

    address private constant WBNB = 0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c;


    /* ========== CONSTRUCTOR ========== */

    constructor() public {}

    receive() external payable {}

    /* ========== FUNCTIONS ========== */

    function withdraw(uint amount) external {
        require(IERC20(WBNB).balanceOf(msg.sender) >= amount, "Not enough Tokens!");

        IERC20(WBNB).transferFrom(msg.sender, address(this), amount);

        IWETH(WBNB).withdraw(amount);

        SafeToken.safeTransferETH(msg.sender, amount);

    }
}
