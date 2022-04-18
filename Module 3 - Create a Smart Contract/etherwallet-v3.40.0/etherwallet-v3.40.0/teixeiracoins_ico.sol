// SPDX-License-Identifier: AFL-1.1
//Teixeiracoins ICO

//Version of compiler
pragma solidity ^0.8.13;

contract teixeiracoin_ico {
  // Introducing the maximum number of Teixeiracoins available for sale
  uint public max_teixeiracoins = 1000000;

  // Introducing the USD to Teixeiracoins conversion rate
  uint public usd_to_teixeiracoins = 1000;

  // Introducing the total number of Teixeiracoins that have been bought by the investors
  uint public total_teixeiracoins_bought = 0;

  // Mapping from the investor address to its equity in Teixeiracoins and USD
  mapping(address => uint) equity_teixeiracoins;
  mapping(address => uint) equity_usd;

  //Checking if an investor can buy Teixeiracoins
  modifier can_buy_teixeiracoins(uint usd_invested) {
    require ((usd_invested * usd_to_teixeiracoins) + total_teixeiracoins_bought <= max_teixeiracoins);
    _;
  }

  // Getting the equity in Teixeiracoins of an investor
  function equity_in_teixeiracoins(address investor) external constant returns (uint) {
    return equity_teixeiracoins[investor];
  }

  // Getting the equity in USD of an investor
  function equity_in_usd(address investor) external constant returns (uint) {
    return equity_usd[investor];
  }

  // Buying Teixeiracoins
  function buy_teixeiracoins(address investor, uint usd_invested) external
  can_buy_teixeiracoins(usd_invested) {
    uint teixeiracoins_bought = usd_invested * usd_to_teixeiracoins;
    equity_teixeiracoins[investor] += teixeiracoins_bought;
    equity_usd[investor] = equity_teixeiracoins[investor] / 1000;
    total_teixeiracoins_bought += teixeiracoins_bought;
  }

  // Selling Teixeiracoins
  function sell_teixeiracoins(address investor, uint teixeiracoins_sold) external {
    equity_teixeiracoins[investor] -= teixeiracoins_sold;
    equity_usd[investor] = equity_teixeiracoins[investor] / 1000;
    total_teixeiracoins_bought -= teixeiracoins_sold;
  }
}