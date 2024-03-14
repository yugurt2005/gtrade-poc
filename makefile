NODE_API_URL = https://arb-mainnet.g.alchemy.com/v2/rL5tvZBCf8HiUyuB5nVj7vvEsPOe9XsE
BLOCK_NUMBER = 189280845


target:
	forge test --fork-url $(NODE_API_URL) --fork-block-number $(BLOCK_NUMBER) -vv

trace:
	forge test --fork-url $(NODE_API_URL) --fork-block-number $(BLOCK_NUMBER) -vvvvv

build:
	forge build