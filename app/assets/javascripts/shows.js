jQuery(function() {
//  $('#tabs').load('/shows/tabs', function() {
    $('.nav-tabs li:first a').click();
//  });
  $('.datepicker').datepicker({
    dateFormat: "yy-mm-dd",
    changeMonth: true,
    changeYear: true,
    maxDate: +0
  });
  $('.chosen-select').chosen({
    create_option: true
  });
  $('#show_venue_id').chosen({
    create_option: false
  });
  $('table#setlist tbody').sortable({
    axis: 'y',
    handle: '.handle',
    update: function(e) {
      return $('#setlist tbody tr').each(function(index, val) {
        console.log(this);
        return $('input.order', this).val(index + 1);
      });
    }
  });
  $('table#setlist').bind('cocoon:after-insert', function(e, insertedItem) {
    var set;
    $('.show_versions_song select', insertedItem).chosen({
      create_option: true
    });
    set = $(insertedItem).prev('tr').find('select.set').val();
    $('select.set', insertedItem).val(set);
    $('input.order').each(function(index) {
      return $(this).val(index + 1);
    });
    return $('.chzn-search input', insertedItem).focus();
  });
  return $('.play-show').click(function(e) {
    var div, playlist;
    if ($('#recording iframe')) {
      $('#recording iframe').remove();
    }
    playlist = document.createElement('iFrame');
    playlist.src = "http://archive.org/embed/" + ($(this).data('source'));
    playlist.width = "100%";
    playlist.height = "28px";
    playlist.style.border = "none";
    div = document.getElementById('recording');
    div.insertBefore(playlist);
    return e.preventDefault();
  });
});

//jQuery(function($) {
//  var url = "https://api.github.com/repos/jgrubb/hobo-companion/commits?callback=?";
//  $.getJSON(url, function(data) {
//    var info = data.data;
//    var html = "";
//    console.log(info);
//    for (var i = 0; i < 5; i++) {
//      html += '<li>';
//      html += '<a href="';
//      html += info[i].html_url;
//      html += '">';
//      html += info[i].commit.message;
//      //html += ' - ';
//      //html += info[i].commit.author.date;
//      html += '</a>';
//    }
//    $('#commits').append(html);
//  });
//});
