const VulnerableContractReentrancy = artifacts.require("VulnerableContractReentrancy");
const AttackerContractReentrancy = artifacts.require("AttackerContractReentrancy");

/*
module.exports = function(deployer) {
    deployer.deploy(VulnerableContractReentrancy).then(function() {
        // suppose the attacker contract needs the address of VulnerableContract as a parameter when deploying
        return deployer.deploy(AttackerContractReentrancy, VulnerableContractReentrancy.address);
    });
};
*/

module.exports = function(deployer) {
    deployer.deploy(VulnerableContractReentrancy).then(function(instance) {
        // use victim contract address as parameter when deploying the attacker
        return deployer.deploy(AttackerContractReentrancy, instance.address);
    });
};
