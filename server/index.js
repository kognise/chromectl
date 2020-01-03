const WebSocket = require('ws')

const chromeServer = new WebSocket.Server({ port: 3123 })
const commandServer = new WebSocket.Server({ port: 3124 })
const commands = {}

chromeServer.on('connection', (ws) => {
  console.log('chrome connection')

  ws.on('message', (message) => {
    const { id, action } = JSON.parse(message)
    commands[id].send(message)
    if (action === 'success') delete commands[id]
  })

  ws.on('close', () => console.log('chrome closed'))
})

commandServer.on('connection', (ws) => {
  console.log('command connection')

  ws.on('message', (message) => {
    const { id, action, payload } = JSON.parse(message)
    commands[id] = ws
    ;([ ...chromeServer.clients ])
      .filter(((client) => client.readyState === WebSocket.OPEN))[0]
      .send(JSON.stringify({ id, action, payload }))
  })

  ws.on('close', () => console.log('command closed'))
})