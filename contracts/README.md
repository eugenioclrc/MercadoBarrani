# Mercado Barrani contracts

Build abi:

```sh
forge b --build-info
```

To test:

1. use utils to generate your private key and public key that is associated with the account via the `PublicKeyInfrastructure` contract.
   ``` sh
utils git:(main) ✗  node 1.keygen.js
privateKey 776194268325110194509280063779128332369654188247377787354144989662771201701
publicKey {
  x: 7069232272768109304789286706430188033303609157459855597327745839535199757054n,
  y: 2336491978620024777884564131269950469381184950656736241358292836548998335919n
}
    ```