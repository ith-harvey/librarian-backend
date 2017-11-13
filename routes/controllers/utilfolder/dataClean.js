const Time = require('./time')
const moment = require('moment');

// two cases:
// 1. for week/year/month/6month
// 2 24 hours

function windowPerform(data, maxTimeWindow, comparisonDaysVsHours) {
  console.log(' /// //// ///////the function is run')
  let snapshotTime
  return data.reduce( (acum, priceHistObj) => {
    snapshotTime = Time.reformat(priceHistObj.created_at)
    console.log('should be unique',snapshotTime)

    // initialize the object
    if (!acum.valueBackThen) acum.valueBackThen = null
    if (!acum.windowData) acum.windowData = []


    // if the maxTimewindow === the created_at price window set value
    if (moment(snapshotTime).isSame(maxTimeWindow)) {
      acum.valueBackThen = priceHistObj.portfolio_value
    }

    // if the maxTimewindow is before created_at price window, push into arr
    if (moment(maxTimeWindow).isBefore(snapshotTime)) {

      if (comparisonDaysVsHours === undefined) {
        comparisonDaysVsHours = () => (Time.justTime(snapshotTime) === '12:00:00')
      }

      if (comparisonDaysVsHours()) { //return arr filled with days or hours

        acum.windowData.push({
            day: snapshotTime,
            value: Number(priceHistObj.portfolio_value),
            amount_eth: Number(priceHistObj.amount_eth)
          })
      }
    }
    return acum
  }, {})
}

module.exports = {
  windowPerform
}
