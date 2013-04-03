# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('.datepicker').datepicker
    dateFormat: "yy-mm-dd"
  $('.chosen-select').chosen
    create_option: true
  $('table#setlist tbody').sortable
    axis: 'y'
    handle: '.handle'
    update: (e) ->
      $('#setlist tbody tr').each (index, val) ->
        console.log(this)
        $('input.order', this).val(index + 1)
  $('table#setlist').bind 'cocoon:after-insert', (e, insertedItem) ->
    $('.show_song_instances_song select', insertedItem).chosen
      create_option: true
  $('table#setlist').bind 'cocoon:before-insert', (e, insertedItem) ->
    $('input.order', insertedItem).val($('tr.tune').length)