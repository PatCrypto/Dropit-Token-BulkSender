

# Token Patcrypto's Dropit FAQ

Here, I am very grateful to you for your interest in our DAPP. Here are some common questions that I hope will help you:

# FAQ's

## Why do I need to do the approval option?
Because it's a safe way, you don't need to transfer tokens to our smart contract directly, and the approval option just grant permission for smart contract to spend up some amount, it's only available when you actually send a token transfer by our contract, so you don't worry about it, just do it.
[About Tokens Standard#Approve](https://theethereum.wiki/w/index.php/ERC20_Token_Standard#Approve_And_TransferFrom_Token_Balance)

## Do I need to do the approval option every time?
No, you don't have to, in my suggestion, you can approve a large amount to smart contract in one time, that you can save some time and tx fees.

## Why is my transaction out of gas?
This is caused by the Ethereum's gas limit. Due to the special nature of your token contract, you can change the send address number per tx to 150, and you will succeed.

## Why was the approval option failed?
Please check if your token smart contract has the following similar code, if so, Just click Reset Aproval Amount, and then, approve again.

if ((_value != 0) && (allowed[msg.sender][_spender] != 0)) throw
```
 function approve(address _spender, uint _value) {
    // To change the approve amount you first have to reduce the addresses`
    //  allowance to zero by calling `approve(_spender, 0)` if it is not
    //  already 0 to mitigate the race condition described here:
    //  https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
    if ((_value != 0) && (allowed[msg.sender][_spender] != 0)) throw;
    allowed[msg.sender][_spender] = _value;
    Approval(msg.sender, _spender, _value);
  }
```

## Why is my token list not showing?
You must make sure you have install MetaMask(https://metamask.io) or Trust Wallet(https://trustwallet.com/) and unlock the right account.

## What's the max address number of one transaction?
The default number is 175, the max number is 255. This depends on the gas limit of Ethereum. If it is too large, the transaction may fail. 175 is the number we have tested with a high success rate. If you still often fail, try to reduce this number.

## What's the tx fee of one transaction?
The default tx fee is Testnet : 0.01 ETH, 0.01 BNB, 0.0007 MATIC, 0.08 AME, Mainnet : 0.025 ETH, 0.1 BNB, 70 MATIC, 8000 AME, But we have VIP membership, you just need to pay Testnet : 1 ETH, 0.001 BNB, 0.007 MATIC, 0.008 AME, Mainnet : 0.25 ETH, 1 BNB, 700 MATIC, 80000 AME to be a VIP, the tx fee will be zero forever for your account.

## Is your smart contract open source?
Sure, you can check them by the following link.

Contracts deployed : Mainnet

| Network Name | Address |
|----------|-------------|
|Ethereum Mainnet |[0xc7426cb8dd7837f1119a6f61fa775dcba21c4413](https://etherscan.io/address/0xc7426cb8dd7837f1119a6f61fa775dcba21c4413#code)|
|Binance Smart Chain |[0xc7426cb8dd7837f1119a6f61fa775dcba21c4413](https://bscscan.com/address/0xc7426cb8dd7837f1119a6f61fa775dcba21c4413#code)|
|Polygon - Mainnet |[0x8050828e2b4effc50e633878b4f306a5dae78f97](https://polygonscan.com/address/0x8050828e2b4effc50e633878b4f306a5dae78f97#code)|
|AME Chain - Mainnet |[0x2c7ed01535d5dc061e9bfafd6206c74c362903b7](https://amescan.io/address/0x2c7ed01535d5dc061e9bfafd6206c74c362903b7#code)|



Contracts deployed : Testnet

| Network Name | Address |
|----------|-------------|
|Kovan Test Network |[0x95849A6e60Cb196cfd68183A4Ca2C24e8baa5530](https://kovan.etherscan.io/address/0x95849A6e60Cb196cfd68183A4Ca2C24e8baa5530#code)|
|Smart Chain - Testnet |[0x2DDA477Dc6EEC6219313305C899c6bc3dDBAbDad](https://testnet.bscscan.com/address/0x2DDA477Dc6EEC6219313305C899c6bc3dDBAbDad#code)|
|Polygon Mumbai |[0x742247a2cdd46f1404dd2b75cbd3b0ebb306d1fc](https://mumbai.polygonscan.com/address/0x742247a2cdd46f1404dd2b75cbd3b0ebb306d1fc#code)|
|AME Chain - Testnet |[0xE64e87296f51296a5e3c044B562f20f85C0de7c5](https://testnet.amescan.io/address/0xE64e87296f51296a5e3c044B562f20f85C0de7c5#code)|








