NODE_API_URL = https://eth-mainnet.g.alchemy.com/v2/umxyzDOdIrQcJFQLvlke5EI9CtT2Ez3X
BLOCK_NUMBER = 18793682

target:
	forge test -vv --fork-url $(NODE_API_URL) --fork-block-number $(BLOCK_NUMBER)

offline:
	forge test -vv