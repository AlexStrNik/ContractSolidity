from handler import (SolidityHandler, )

abi = """[ { "constant": false, "inputs": [], "name": "accept", "outputs": [], "payable": false, "type": "function" }, { "inputs": [], "payable": false, "type": "constructor" }, { "anonymous": false, "inputs": [ { "indexed": true, "name": "who", "type": "address" } ], "name": "Accepted", "type": "event" } ]"""
e = SolidityHandler(abi, "0xcD54E96b90f61961365dC84B6Cb77beEc0a87135")
actor = '0x5612a9a1eb122fbb7743e7ebd3ca9d5d4bf7635d'
e.web.personal.unlockAccount(actor, "1234567890")

@e.handle("Accepted")
def printt(filt):
    print(filt)
    e.deployed_contract.transact(transaction={'from':actor}).accept()
    print(type(filt))


e.start("Accepted")

while True:
    pass