# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery(document).ready ($) ->
  $('.datepicker').datepicker
    dateFormat: "yy-mm-dd"
  $('.chosen-select').chosen()
  $('body').bind 'cocoon:after-insert', (e, insertedItem) ->
    $('.show_song_instances_song select', insertedItem).chosen()
    $('.show_song_instances_position input.hidden').val($('tr.tune').length)