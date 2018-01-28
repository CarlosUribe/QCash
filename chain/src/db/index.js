const jsonfile = require('jsonfile')
const path = require('path')
const uuidv4 = require('uuid/v4')

const USER_PATH = path.join(__dirname, 'users.json')
const BLOCK_PATH = path.join(__dirname, 'block.json')

let users = jsonfile.readFileSync(USER_PATH)

const getUsers = () => users

const saveUser = (name) => {
  const user = {name, id: uuidv4(), valance: 0}
  users = users.concat(user)
  jsonfile.writeFileSync(USER_PATH, users)
  return user
}

const modifyValance = (senderId, recieverId, amount) => {
  const senderIdx = users.findIndex(({ id }) => senderId === id)
  const recieverIdx = users.findIndex(({ id }) => recieverId === id)

  const senderAmount = users[senderIdx].valance
  const recieverAmount = users[recieverIdx].valance

  if (senderAmount < amount) {
    return 0
  }

  users[senderIdx].valance = senderAmount - amount
  users[recieverIdx].valance = recieverAmount + amount
  jsonfile.writeFileSync(USER_PATH, users)
  return users[recieverIdx].valance
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
  modifyValance,
  saveBlock,
  getChain
}