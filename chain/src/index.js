const {
  GraphQLServer
} = require('graphql-yoga')

const fs = require('fs')
const path = require('path')
const bodyParser = require('body-parser')

const algorithmia = require("algorithmia");

const client = algorithmia("simFdgT1f4ko3XDQIjFovV9QKfD1");

const Blockchain = require('./chain')

const db = require('./db')
const anomaly = require('./anomaly')

const typeDefs = fs.readFileSync(path.join(__dirname, 'schema.graphql'), 'utf-8')

let blockchain = new Blockchain()

const resolvers = {
  Query: {
    getAnomalies: (_, {
      name
    }) => anomaly(),
  },
  Mutation: {
    createUser: (_, {
      name
    }) => db.saveUser(name),
    changeBalance: (_, {
        senderId,
        recieverId,
        amount
      }) =>
      db.modifyBalance(senderId, recieverId, amount)
  }
}
const server = new GraphQLServer({
  typeDefs,
  resolvers
})

server.express.use(bodyParser.json())

server.express.use(function (req, res, next) {
  blockchain.appendData(JSON.stringify(req.body))
  next()
})

server.start({
    playground: '/play'
  },
  () => {
    console.log('Server is running on localhost:4000')
  })