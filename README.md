# MERCADO BARRANI <small>A ZK-USDC Privacy Token</small>


## Table of Contents

- [Introduction](#Introduction)
- [Workflow](#Workflow)
- [Contracts](#Contracts)
- [Circuits](#Circuits)
- [Citations and References](#Citations-and-References)
-

## Introduction

TODO

## Workflow

<img src="./step1.png" />

<img src="./step2.png" />

## Contracts

### Layer 1 Contracts

- Vault: [0x4DFB5C0F45AE4e0C4cA57E0238FcCcfAb9b36003](https://sepolia.etherscan.io/address/0x4DFB5C0F45AE4e0C4cA57E0238FcCcfAb9b36003#code)
- Deposit contract: [0xc04e68Ba3c8094097976EA542c708a2a671318A7](https://sepolia.etherscan.io/address/0xc04e68Ba3c8094097976EA542c708a2a671318A7#code)
- Tx of deposit in L1: [0x305f0495f32c.....1a135b16da](https://sepolia.etherscan.io/tx/0x305f0495f32c6321ff98898c5d52738370b5764f77aab521537a261a135b16da)

### Layer 2 Contracts

- PublicKeyInfrastructure: [0xc54ae1172a7e671002c3bf73c8d75e54c9d2effe](https://sepolia.scrollscan.com/address/0xc54ae1172a7e671002c3bf73c8d75e54c9d2effe)
- UltraVerifier Mint: [0x3ec5c0a31d779cded116741bc3e0f2713e39ca14](https://sepolia.scrollscan.com/address/0x3ec5c0a31d779cded116741bc3e0f2713e39ca14)
- UltraVerifier Transfer: [0x4c743c69e88f146d4dd434cb662024c86c2f0997](https://sepolia.scrollscan.com/address/0x4c743c69e88f146d4dd434cb662024c86c2f0997)
- UltraVerifier TransferToNew: [0xad43abaed15e41176f666df2935f1249560e4456](https://sepolia.scrollscan.com/address/0xad43abaed15e41176f666df2935f1249560e4456)
- PrivateToken: [0x55ee3c0e8ae6c8634be3c3ff90852d838898089a](https://sepolia.scrollscan.com/address/0x55ee3c0e8ae6c8634be3c3ff90852d838898089a)

- Tx mint: [0x20e3e282e5f81394856b9249085aebfb056e2ed6dc9eac96b1a211d39280b7b3](https://sepolia.scrollscan.com/tx/0x20e3e282e5f81394856b9249085aebfb056e2ed6dc9eac96b1a211d39280b7b3)


<details>

<summary>Layer 1 vault and deposit contract 0x4DFB5C0F45AE4e0C4cA57E0238FcCcfAb9b36003</summary>

Deployed with command:
```sh
forge script script/Layer1.s.sol --rpc-url=https://eth-sepolia.public.blastapi.io --verify --private-key=0x... --etherscan-api-key=...
[⠊] Compiling...
No files changed, compilation skipped
Script ran successfully.

== Return ==
vault: contract Vault 0x4DFB5C0F45AE4e0C4cA57E0238FcCcfAb9b36003

## Setting up 1 EVM.

==========================

Chain 11155111

Estimated gas price: 7.003102858 gwei

Estimated total gas used for script: 777896

Estimated amount required: 0.005447685700826768 ETH

==========================

##### sepolia
✅  [Success]Hash: 0xf4c0e86dc5483fa0fbaa09b46c4708e11d86e03be2c7b1ccb9c026bb88f8353d
Contract Address: 0x4DFB5C0F45AE4e0C4cA57E0238FcCcfAb9b36003
Block: 6431154
Paid: 0.00244380533625144 ETH (598640 gas * 4.082262021 gwei)

✅ Sequence #1 on sepolia | Total Paid: 0.00244380533625144 ETH (598640 gas * avg 4.082262021 gwei)
...
Submitting verification for [src/Layer1/Vault.sol:Vault] 0x4DFB5C0F45AE4e0C4cA57E0238FcCcfAb9b36003.
Submitted contract for verification:
        Response: `OK`
```

</details>

</summary>

### ZK-Scroll Contracts

todo

## Circuits

Mint circuit

Transfer to new

Transfer

Burn

## Citations and References

It would be impossible to me do this with out the awesome work of other researchers that have done all the hard work for me :D

- https://files.sri.inf.ethz.ch/website/papers/sp22-zeestar.pdf
- https://es.wikipedia.org/wiki/Cifrado_ElGamal
- **Most or circuit are based on this post:** https://medium.com/@jat9292zksnarks-homomorphic-encryption-ethereums-privacy-new-frontier-b30357236a7a]
- https://github.com/colinnielsen/ecrecover-noir/tree/main
- https://github.com/Foulks-Plb/noir-lang-zkp-homomorphic/tree/main
