const JsonServer = require('json-server')

// Returns an Express server
const server = JsonServer.create()

// Set default middlewares (logger, static, cors and no-cache)
server.use(JsonServer.defaults())

const router = JsonServer.router(__dirname + '/db.json')
server.use(router)

console.log('Listening at 4000')
server.listen(4000)
