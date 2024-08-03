cd exponential_elgamal

nargo compile
nargo prove
nargo verify
nargo codegen-verifier

## Front end wasm compile
cd babygiant
wasm-pack build --target web --release

cd ../.. # back to root

cd mint
nargo compile
nargo prove
nargo verify
nargo codegen-verifier

cd ..

cd transfer
nargo compile
nargo prove
nargo verify
nargo codegen-verifier

cd ..

cd transfer_to_new
nargo compile
nargo prove
nargo verify
nargo codegen-verifier

cd ..

cp -R transfer_to_new/contract/ ../contracts/src/verifiers/
cp -R transfer/contract/ ../contracts/src/verifiers/
cp -R mint/contract/ ../contracts/src/verifiers/


