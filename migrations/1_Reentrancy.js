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
        // 确保使用新部署的实例的地址
        return deployer.deploy(AttackerContractReentrancy, instance.address);
    });
};
