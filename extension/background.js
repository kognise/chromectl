const ws = new WebSocket('ws://localhost:3123')

ws.addEventListener('message', ({ data: message }) => {
  const { action, payload, id } = JSON.parse(message)
  const reply = (payload = {}, action = 'success') => ws.send(JSON.stringify({ id, action, payload }))

  try {
    switch (action) {
      case 'open': {
        if (!payload.url) throw new Error('No url specified')

        chrome.tabs.create({ url: payload.url }, (tab) => {
          reply({ id: tab.id })
        })

        break
      }

      case 'navigate': {
        if (!payload.id) throw new Error('No tab id specified')
        if (!payload.url) throw new Error('No url specified')
        
        chrome.tabs.update(payload.id, { url: payload.url }, () => {
          reply()
        })

        break
      }

      case 'select': {
        if (!payload.id) throw new Error('No tab id specified')
        
        chrome.tabs.update(payload.id, { active: true }, () => {
          reply()
        })

        break
      }

      default: throw new Error('Unknown action')
    }
  } catch (error) {
    reply({ message: error.message }, 'error')
  }
})

// ws.addEventListener('open', () => ws.send({ test:'true' }))