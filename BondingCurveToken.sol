// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title BondingCurveToken
 * @dev A mathematical model implementation in Solidity where token price increases
 *      based on supply using a bonding curve formula.
 *      Demonstrates translation of a mathematical model into secure, efficient smart contract logic.
 */

contract BondingCurveToken {
    string public name = "BondingCurve Token";
    string public symbol = "BCT";
    uint8 public decimals = 18;
    uint256 public totalSupply;
    uint256 public constant BASE_PRICE = 0.001 ether; // initial price per token
    uint256 public constant PRICE_SLOPE = 0.0000001 ether; // price increment per token

    mapping(address => uint256) public balanceOf;

    event TokensPurchased(address indexed buyer, uint256 amount, uint256 cost);
    event TokensSold(address indexed seller, uint256 amount, uint256 revenue);

    function currentPrice() public view returns (uint256) {
        return BASE_PRICE + (totalSupply * PRICE_SLOPE);
    }

    function calculateCost(uint256 amount) public view returns (uint256) {
        uint256 a = BASE_PRICE * amount;
        uint256 b = (PRICE_SLOPE * amount * amount) / 2;
        return a + b;
    }

    function buyTokens(uint256 amount) external payable {
        uint256 cost = calculateCost(amount);
        require(msg.value >= cost, "Insufficient ETH sent");

        totalSupply += amount;
        balanceOf[msg.sender] += amount;

        emit TokensPurchased(msg.sender, amount, cost);

        if (msg.value > cost) {
            payable(msg.sender).transfer(msg.value - cost);
        }
    }

    function sellTokens(uint256 amount) external {
        require(balanceOf[msg.sender] >= amount, "Insufficient tokens");

        uint256 revenue = (BASE_PRICE * amount) - ((PRICE_SLOPE * amount * amount) / 2);
        require(address(this).balance >= revenue, "Not enough ETH in contract");

        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;
        payable(msg.sender).transfer(revenue);

        emit TokensSold(msg.sender, amount, revenue);
    }

    receive() external payable {}
}
