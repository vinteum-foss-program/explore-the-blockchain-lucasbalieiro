# Which tx in block 257,343 spends the coinbase output of block 256,128?
funding_block_hash=$(bitcoin-cli getblockhash 256128)
funding_coinbase_tx=$(bitcoin-cli getblock $funding_block_hash | jq -r .tx[0])

spending_block_hash=$(bitcoin-cli getblockhash 257343)
spending_block_data=$(bitcoin-cli getblock $spending_block_hash 2)

echo $spending_block_data | jq --arg txid "$funding_coinbase_tx" '.tx[] | select(.vin[].txid == $txid).txid'
