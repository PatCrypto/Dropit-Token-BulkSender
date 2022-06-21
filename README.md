# Token Patcrypto's Dropit!
This DAPP was used to send Token, ETH, BNB, MATIC or AME to many addresses in one transaction, and that can help user to save tx fee


# Problem:
Previously in Ethereum Network, additional tools were required in order to transfer many tokens and coins at once.
Many people still do this manually, one transaction at a time. This process is time consuming and prone to an error.

# Solution:
This DAPP allows a user to send thousands of token transfers in a very effecient way by batching them in groups of 1 - 255 token transfers per transaction. This automation saves time by automatically generating transactions to MetaMask or Trust Wallet. Finally, this tool allows a user to maintain security of their account by delegating the trust of their private keys to a secure MetaMask or Trust wallet.

# How to use:
1. Install [MetaMask](https://metamask.io) or [Trust Wallet](https://trustwallet.com/).
2. Make sure you have an account in MetaMask or Trust Wallet which has a token balance.
3. Make sure your MetaMask or Trust Wallet is pointed to the network that you would like to use.
4. Make sure your MetaMask or Trust Wallet account is unlocked.
5. Go to https://dropit.patcrypto.com/
6. Wait for the full page to load.
7. Select a token from the dropdown that you would like to send.
8. Provide either EXCEL, CSV or TXT file with addresses and values.
9. Click next.
10. You need to approve a enough amount to our contract.
11. Once the approve transaction is complete, click Next, go to the Send List, click Send, MetaMask will automatically generate a transaction for your token (255 addresses per transaction).
12. Done!


Example EXCEL / CSV:

| Address   |Amount |
|----------|-------------|
|0xedbaa78675732b8d22342157d3af58344ed0514e |32|
|0x4dc442f39661f68676a0x2f632f49df1db2f4338a |9.23|

Example TXT:
```
0x34215773514ea86b8d272d3a44e570f5832d,32
0x4a8db22f6321461f686762f632196330a4dc,9.23
```

```
Proof of work:

https://kovan.etherscan.io/tx/0xd7f3dcc3e70faa72f56d1a335ae1952f2557769fe4018c2dd7777b68d7236567
https://testnet.bscscan.com/tx/0x98064f965f79ea00b752b6b38728059a0cf282936d07177f8e243848cf4d5c7a
https://mumbai.polygonscan.com/tx/0xef7b111c505d2e2b0b762ca893604974cc1c61149cceaba39a3d46cea125e6cb
```

# Contract deployed and Source Code

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


# Disclaimer
I am not responsible for any loss from transactions derived by Patcrypto's Dropit.  Some of the underlying JavaScript libraries and Ethereum tools that were used are under active development. The website and smart contract has been thoroughly tested, there is always the possibility something unexpected happens resulting in losses of Ethereum and/or tokens.

Any tokens, ETH, BNB, MATIC or AME you transfer to the Patcrypto's Dropit will be sent out to the addresses that you provided.

I encourage you to assess its security before using the Patcrypto's Dropit DAPP.
