const jsonfile = require('jsonfile')
const path = require('path')
const uuidv4 = require('uuid/v4')
const moment = require('moment')

const USER_PATH = path.join(__dirname, 'users.json')
const BLOCK_PATH = path.join(__dirname, 'block.json')
const TRAN_PATH = path.join(__dirname, 'tran.json')

let users = jsonfile.readFileSync(USER_PATH)

const getUsers = () => users

const saveUser = (name) => {
  const user = {name, id: uuidv4(), balance: 0}
  users = users.concat(user)
  jsonfile.writeFileSync(USER_PATH, users)
  return user
}

let tran = jsonfile.readFileSync(TRAN_PATH)

const appendTran = (id, amount) => {
  const obj = {amount, date: moment().format()} 
  if (tran[id]) {
    tran[id] = tran[id].concat(obj)
  } else {
    tran = Object.assign({}, tran, {[id] : [ obj ]})
  }

  console.log({[id] : [ obj ]})
  console.log(tran)
  jsonfile.writeFileSync(TRAN_PATH, tran)
  // chain = chain.concat(block)
  // jsonfile.writeFileSync(BLOCK_PATH, chain)
}

const modifyBalance = (senderId, recieverId, amount) => {
  const senderIdx = users.findIndex(({ id }) => senderId === id)
  const recieverIdx = users.findIndex(({ id }) => recieverId === id)

  const senderAmount = users[senderIdx].balance
  const recieverAmount = users[recieverIdx].balance
  console.log({senderAmount})
  console.log({recieverAmount})
  if (senderAmount < amount) {
    return 0
  }

  appendTran(senderId, - amount)
  appendTran(recieverId, amount)

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

const getTrans = () => jsonfile.readFileSync(TRAN_PATH)

const KEY_PATH = path.join(__dirname, 'key.json')

const getKeys = () => jsonfile.readFileSync(KEY_PATH)

module.exports = {
  getUsers,
  saveUser,
  modifyBalance,
  saveBlock,
  getChain,
  getTrans,
  getKeys
}