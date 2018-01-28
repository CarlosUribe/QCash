const jsonfile = require('jsonfile')

const algorithmia = require("algorithmia");

const db = require('./db')

const client = algorithmia(db.getKeys().algorithmia)

const dumy = [{
    amount: 1,
    date: '1'
  },
  {
    amount: 1,
    date: '1'
  },
  {
    amount: 1,
    date: '1'
  }
]

module.exports = (id) => new Promise((resolve, reject) => {
  const orgTrans = db.getTrans()[id]
  const input = [orgTrans.map(({ amount, date })=> amount), 0.5, 50]

  return client.algo("TimeSeries/ThresholdAnomalyDetection/0.2.0")
  .pipe(input)
  .then(function(response) {
    const res = response.get().filter((a) => a !== 0)

    const populated = res.map((foundAmount) => {
      const findIndx = orgTrans.findIndex(({ amount }) => amount === foundAmount)
      console.log({ findIndx })
      const found = orgTrans[findIndx]
      return found
    })

    resolve(populated)

  })
})