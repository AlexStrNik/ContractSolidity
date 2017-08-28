from threading import Thread

import time
from web3 import Web3
from web3 import eth
from web3.utils.transactions import wait_for_transaction_receipt
from web3.utils.compat import Timeout
import json


class SolidityHandler:
    def __init__(self, abi, address, provider='http://127.0.0.1:8545'):
        self.abi = abi
        self.address = address
        self.handlers = {}
        self.web = Web3(Web3.HTTPProvider(provider))
        MyContract = self.web.eth.contract(abi=json.loads(abi))
        self.deployed_contract = MyContract(address)

    def handle(self, name):
        def decor(func):
            self.handlers[name] = func
            return func

        return decor

    def start(self, name):
        filters = self.deployed_contract.on(name, {})
        filters.watch(self.handlers[name])
