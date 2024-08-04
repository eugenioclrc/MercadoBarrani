const  { buildBabyjub } = require("circomlibjs");
const crypto = require("crypto");

let babyJub;

async function getBabyJub() {
  if (!babyJub) {
    babyJub = await buildBabyjub();
  }
  return babyJub;
}

async function getRandomBigInt(maxBigInt) {
    // Calculate the byte length
    const byteLength = (maxBigInt.toString(16).length + 1) >> 1;
    while (true) {
      const buf = crypto.randomBytes(byteLength);
      let num = BigInt("0x" + buf.toString("hex"));
  
      if (num <= maxBigInt) {
        return num;
      }
    }
  }


function _uint8ArrayToBigInt(bytes) {
    let hex = [...bytes].map((b) => b.toString(16).padStart(2, "0")).join("");
    return BigInt("0x" + hex);
  }
  
  function _bigIntToUint8Array(bigInt) {
    let hex = bigInt.toString(16);
  
    // Ensure even number of characters
    if (hex.length % 2 !== 0) {
        hex = '0' + hex;
    }
  
    const bytes = new Uint8Array(32);
    const hexLength = hex.length;
  
    // Start from the end of the hex string and assign byte values to the end of the Uint8Array
    for (let i = hexLength, byteIndex = 31; i > 0; i -= 2, byteIndex--) {
        const byteStr = i >= 2 ? hex.slice(i - 2, i) : hex.slice(0, 1); // Handle the scenario where hex has an odd length
        bytes[byteIndex] = parseInt(byteStr, 16);
    }
    return bytes;
  }

async function generatePrivateAndPublicKey() {
  const max_value = BigInt(
    "2736030358979909402780800718157159386076813972158567259200215660948447373041"
  ); // max value should be l (https://eips.ethereum.org/EIPS/eip-2494), the order of the big subgroup to avoid modulo bias
  const privateKey = await getRandomBigInt(max_value);
  const publicKey = await privateToPublicKey(privateKey);
  return { privateKey: privateKey, publicKey: publicKey };
}

// Utils functions (should be called directly by the dapp)
async function privateToPublicKey(privateKey) {
  const babyJubInstance = await getBabyJub();
  const publicKeyPoint = babyJubInstance.mulPointEscalar(
    babyJubInstance.Base8,
    privateKey
  ); // A point on Baby Jubjub : C = (CX, Cy)
  return {
    x: _uint8ArrayToBigInt(
      babyJubInstance.F.fromMontgomery(
        babyJubInstance.F.e(publicKeyPoint[0])
      ).reverse()
    ), // fromMontgomery because circomlibjs uses the Montgomery form by default, but we need the Twisted Edwards form in Noir
    y: _uint8ArrayToBigInt(
      babyJubInstance.F.fromMontgomery(
        babyJubInstance.F.e(publicKeyPoint[1])
      ).reverse()
    ),
  };
}

async function main() {
    const { privateKey, publicKey } = await generatePrivateAndPublicKey();
    console.log("privateKey", privateKey.toString());
    console.log("publicKey", publicKey);
    process.exit(0);

}

main();