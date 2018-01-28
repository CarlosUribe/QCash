const SHA256 = require('crypto-js/sha256')
const jsonfile = require('jsonfile')
const moment =  require('moment')

const db = require('./db')

class Block {
	constructor(index, timestamp, data, previousHash = '') {
		this.index = index;
		this.previousHash = previousHash;
		this.timestamp = timestamp
		this.data = data
		this.hash = this.calculateHash()
	}
	toString() {
		return this
	}
	calculateHash() {
		return SHA256(this.index + this.previousHash + this.timestamp + JSON.stringify(this.data)).toString()
	}
}

class Blockchain {
	appendData(data) {
		const block = new Block(
			this.chain.length ,
			moment().format(),
			data,
			this.chain[this.chain.length - 1].previousHash
		)
		this.addBlock(block)
	}
	constructor() {
		const chain = db.getChain()
		this.chain = chain.length === 0 ?
		[this.createGenesisBlock()]:
		chain
	}
	createGenesisBlock() {
		let block = new Block(0, moment().format(), 'Genesis block by roderik', '0')
		db.saveBlock(block)
		return block
	}
	addBlock(newBlock) {
		newBlock.previousHash = this.getLatestBlock().hash

		newBlock.hash = newBlock.calculateHash()
		db.saveBlock(newBlock)
		this.chain.push(newBlock)
	}
	getLatestBlock() {
		return this.chain[this.chain.length - 1]
	}
	listblockchain() {
		return this.chain
	}
	isChainValid() {
		for (let i = 1; i < this.chain.length; i++) {
			const currentBlock = this.chain[i]

			const previousBlock = this.chain[i - 1]

			if (currentBlock.hash !== currentBlock.calculateHash()) {
				return false
			}
			if (currentBlock.previousHash !== previousBlock.hash) {
				return false;
			}
			return true
		}
	}
}

module.exports = Blockchain

// let blockchain = new Blockchain()

// blockchain.addBlock(new Block(1, "20/07/07", {
// 	sender: 'roderik',
// 	receiver: 'javascript cummunity',
// 	amount: 4
// }))

// console.log(blockchain.listblockchain())

// console.log(`valid? ${blockchain.isChainValid()}`)

