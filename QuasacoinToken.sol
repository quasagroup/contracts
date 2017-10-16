pragma solidity ^0.4.11;

import './base.sol';

/**
 * @title Quasacoin token
 * Based on code by OpenZeppelin MintableToken.sol
 
  + added frozing when minting
 
 */

contract QuasacoinToken is StandardToken, Ownable {
    
  string public name = "Quasacoin";
  string public symbol = "QUA";
  uint public decimals = 8;


  

    
  event Mint(address indexed to, uint256 amount);
  event MintFinished();

  bool public mintingFinished = false;


  modifier canMint() {
    require(!mintingFinished);
    _;
  }

  /**
   * @dev Function to mint tokens
   * @param _to The address that will receive the minted tokens.
   * @param _amount The amount of tokens to mint.
   * @return A boolean that indicates if the operation was successful.
   */
  function mint(address _to, uint256 _amount) onlyOwner canMint public returns (bool) {
    require(_to != address(0));
    require(_amount > 0);

    totalSupply = totalSupply.add(_amount);
    balances[_to] = balances[_to].add(_amount);

    uint frozenTime = 0; 
    if(now < 1520380800) {
      // выпуск                      до 15.11.17 00:00:00 (1510704000) - заморозка до 15.02.18 00:00:00 (1518652800)
      if(now < 1510704000)
        frozenTime = 1518652800;
      // выпуск c 15.11.17 00:00:00  до 29.11.17 00:00:00 (1511913600) - заморозка до 21.02.18 00:00:00 (1519171200)     
      else if(now < 1511913600)
        frozenTime = 1519171200;
      // выпуск c 29.11.17 00:00:00  до 30.12.17 00:00:00 (1514592000) - заморозка до 26.02.18 00:00:00 (1519603200)
      else if(now < 1514592000)
        frozenTime = 1519603200;
      // выпуск c 30.12.17 00:00:00  до 12.01.18 00:00:00 (1515715200) - заморозка до 01.03.18 00:00:00 (1519862400)
      else if(now < 1515715200)
        frozenTime = 1519862400;
      // выпуск c 12.01.18 00:00:00  до 07.03.18 00:00:00 (1520380800) - заморозка до 07.03.18 00:00:00 (1520380800)
      else if(now < 1520380800)
        frozenTime = 1520380800;
      unfrozeTimestamp[_to] = frozenTime;
    }

    Mint(_to, _amount);
    Transfer(0x0, _to, _amount);
    return true;
  }

  /**
   * @dev Function to stop minting new tokens.
   * @return True if the operation was successful.
   */
  function finishMinting() onlyOwner public returns (bool) {
    mintingFinished = true;
    MintFinished();
    return true;
  }
}
