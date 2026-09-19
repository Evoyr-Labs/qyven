// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract QyvenToken {
    string public name;
    string public symbol;
    uint8 public constant decimals = 18;
    uint256 public totalSupply;
    address public immutable creator;

    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    constructor(string memory name_, string memory symbol_, uint256 supply_, address creator_) {
        require(bytes(name_).length > 0, "NAME_EMPTY");
        require(bytes(symbol_).length > 0, "SYMBOL_EMPTY");
        name = name_;
        symbol = symbol_;
        creator = creator_;
        totalSupply = supply_ * 10 ** uint256(decimals);
        balanceOf[creator_] = totalSupply;
        emit Transfer(address(0), creator_, totalSupply);
    }

    function transfer(address to, uint256 amount) external returns (bool) {
        _transfer(msg.sender, to, amount);
        return true;
    }

    function approve(address spender, uint256 amount) external returns (bool) {
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(address from, address to, uint256 amount) external returns (bool) {
        uint256 allowed = allowance[from][msg.sender];
        require(allowed >= amount, "ALLOWANCE");
        if (allowed != type(uint256).max) allowance[from][msg.sender] = allowed - amount;
        _transfer(from, to, amount);
        return true;
    }

    function _transfer(address from, address to, uint256 amount) internal {
        require(to != address(0), "ZERO_TO");
        require(balanceOf[from] >= amount, "BALANCE");
        balanceOf[from] -= amount;
        balanceOf[to] += amount;
        emit Transfer(from, to, amount);
    }
}

contract QyvenFactory {
    address[] public allTokens;
    mapping(address => address[]) public tokensByCreator;

    event TokenCreated(
        address indexed token,
        address indexed creator,
        string name,
        string symbol,
        uint256 supply
    );

    function createToken(
        string calldata name,
        string calldata symbol,
        uint256 supply
    ) external returns (address token) {
        require(supply > 0, "SUPPLY_ZERO");
        QyvenToken deployed = new QyvenToken(name, symbol, supply, msg.sender);
        token = address(deployed);
        allTokens.push(token);
        tokensByCreator[msg.sender].push(token);
        emit TokenCreated(token, msg.sender, name, symbol, supply);
    }

    function allTokensLength() external view returns (uint256) {
        return allTokens.length;
    }

    function creatorTokensLength(address creator) external view returns (uint256) {
        return tokensByCreator[creator].length;
    }
}
