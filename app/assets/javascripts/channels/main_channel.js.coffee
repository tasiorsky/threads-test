unless App.backgroundTaskSub
  App.backgroundTaskSub = App.cable.subscriptions.create 'MainChannel',
    received: (data) -> console.log(data)
