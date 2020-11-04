#= require jquery

$(document).ready ->
  $('body').on 'click', '.btn', -> $('tbody').html('')

  $('.btn').on 'ajax:before', ->
    $(this).prop('disabled', true)
    $(this).toggleClass('disabled', true)
  $('.btn').on 'ajax:success', ->
    $(this).prop('disabled', false)
    $(this).toggleClass('disabled', false)
