unless App.backgroundTaskSub
  App.backgroundTaskSub = App.cable.subscriptions.create 'MainChannel',
    received: (data) ->
      $table = $('table')

      $cell = $table.find("td.#{data.thread}")
      if $cell.length == 0
        $row = $("<tr><td class='#{data.thread}'></td><td></td></tr>")
        $table.find('tbody').append($row)
        $cell = $row.find('td')

      values = data.values_in_thread.join(' -> ')
      $cell.text("Values change in thread #{data.thread}:")
      $cell.next().text(values)
