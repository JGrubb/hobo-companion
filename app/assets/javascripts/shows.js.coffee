# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('.datepicker').datepicker
    dateFormat: "yy-mm-dd"
    changeMonth: true
    changeYear: true
    maxDate: +0
  $('.chosen-select').chosen
    create_option: true
  $('#show_venue_id').chosen
    create_option: false
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
  $('.play-show').click ->
    $('#recording iframe').remove() if $('#recording iframe')
    playlist = document.createElement('iFrame')
    playlist.src = "http://archive.org/embed/#{$(this).data('source')}"
    playlist.width = "100%"
    playlist.height = "28px"
    playlist.style.border = "none"
    div = document.getElementById('recording')
    div.insertBefore(playlist)