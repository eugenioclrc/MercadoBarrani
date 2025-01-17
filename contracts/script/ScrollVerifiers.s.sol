// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";

import {PublicKeyInfrastructure} from "../src/private-token/PublicKeyInfrastructure.sol";
import {UltraVerifier as MintUltraVerifier} from "../src/verifiers/mint/plonk_vk.sol";
import {UltraVerifier as TransferUltraVerifier} from "../src/verifiers/transfer/plonk_vk.sol";
import {UltraVerifier as TransferToNewUltraVerifier} from "../src/verifiers/transfer_to_new/plonk_vk.sol";

contract VerifiersDeployScript is Script {

    function setUp() public {}

    function run() public returns(address PKIAddress, address MintVerifierAddress, address TransferVerifierAddress, address TransferToNewVerifierAddress) {
        vm.startBroadcast();

        PublicKeyInfrastructure pki = new PublicKeyInfrastructure();
        MintUltraVerifier mintVerifier = new MintUltraVerifier();
        TransferUltraVerifier transferVerifier = new TransferUltraVerifier();
        TransferToNewUltraVerifier transferToNewVerifier = new TransferToNewUltraVerifier();

        PKIAddress = address(pki);
        MintVerifierAddress = address(mintVerifier);
        TransferVerifierAddress = address(transferVerifier);
        TransferToNewVerifierAddress = address(transferToNewVerifier);

        vm.stopBroadcast();
    }
}
