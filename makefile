NODE_API_URL = YOUR_NODE_API_URL (e.g., alchemy)
BLOCK_NUMBER = 189280845


target:
	forge test --fork-url $(NODE_API_URL) --fork-block-number $(BLOCK_NUMBER) -vv

trace:
	forge test --fork-url $(NODE_API_URL) --fork-block-number $(BLOCK_NUMBER) -vvvvv

build:
	forge build