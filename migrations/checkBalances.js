const VulnerableContractReentrancy = artifacts.require("VulnerableContractReentrancy");

module.exports = async function(callback) {
    try {
        let vulnerable = await VulnerableContractReentrancy.deployed();
        let accounts = await web3.eth.getAccounts();
        for (let i = 0; i < accounts.length; i++) {
            let balance = await vulnerable.balances(accounts[i]);
            console.log(`Account ${i} balance:`, web3.utils.fromWei(balance.toString(), "ether"), "ETH");
        }
    } catch (error) {
        console.error(error);
    }
    callback();
};
