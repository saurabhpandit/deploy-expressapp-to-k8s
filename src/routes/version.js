const express = require('express')
const router = express.Router()
// Read metadata from package.json, this could also reside in separate
// metadata file but then it'll be duplicated
const { version, description, name } = require('../../package.json')

let statusRes = {}
statusRes[name] = [
    {
        version: version,
        description: description,
        lastcommitsha: process.env.SHA || 'not set'
    }
]

router.get('/', function (req, res) {
    res.send(statusRes)
})

module.exports = router
