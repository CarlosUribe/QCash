const jsonfile = require('jsonfile')
const path = require('path')
const uuidv4 = require('uuid/v4')

const USER_PATH = path.join(__dirname, 'users.json')
const BLOCK_PATH = path.join(__dirname, 'block.json')

let users = jsonfile.readFileSync(USER_PATH)

const getUsers = () => users

const saveUser = (name) => {
  const user = {name, id: uuidv4(), balance: 0}
  users = users.concat(user)
  jsonfile.writeFileSync(USER_PATH, users)
  return user
}

const modifyBalance = (senderId, recieverId, amount) => {
  const senderIdx = users.findIndex(({ id }) => senderId === id)
  const recieverIdx = users.findIndex(({ id }) => recieverId === id)

  const senderAmount = users[senderIdx].balance
  const recieverAmount = users[recieverIdx].balance

  if (senderAmount < amount) {
    return 0
  }

  users[senderIdx].balance = senderAmount - amount
  users[recieverIdx].balance = recieverAmount + amount
  jsonfile.writeFileSync(USER_PATH, users)
  return users[recieverIdx].balance
}

let chain = jsonfile.readFileSync(BLOCK_PATH)

const saveBlock = (block) => {
  chain = chain.concat(block) 
  jsonfile.writeFileSync(BLOCK_PATH, chain)
  return block
}

const getChain = () => jsonfile.readFileSync(BLOCK_PATH)

module.exports = {
  getUsers,
  saveUser,
  modifyBalance,
  saveBlock,
  getChain
}