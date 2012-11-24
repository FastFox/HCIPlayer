// Generated by CoffeeScript 1.3.3
var playlistData;

playlistData = [
  {
    artist: 'Nitrous Oxide',
    title: 'Alderaan'
  }, {
    artist: 'Nitrous Oxide',
    title: 'Alderaan 2'
  }
];

$(document).ready(function() {
  return $('ul.list li').live('click', function(e) {
    return $(this).toggleClass('open closed').parent().children('.open').not(this).toggleClass('open closed');
  });
});

$('#playlist').live('pagebeforecreate', function() {
  $('#playlistItems .thumbup').live('click', function(e) {
    if ($(this).hasClass('liked')) {
      console.log('Like weghalen');
    } else {
      console.log('Like toevoegen');
    }
    return false;
  });
  $('#playlistItems .thumbdown').live('click', function(e) {
    if ($(this).hasClass('disliked')) {
      console.log('Dislike weghalen');
    } else {
      console.log('Dislike toevoegen');
    }
    return false;
  });
  $.templates({
    playlistItem: '#playlistItem'
  });
  $.link.playlistItem('#playlistItems', playlistData);
  return $.observable(playlistData).insert(playlistData.length, {
    artist: 'Michiel',
    title: 'Track 3'
  });
});

$('#getSuggestions').live('pagebeforecreate', function() {
  return $('#suggestionItems .addTrack').live('click', function(e) {
    $(this).toggleClass('addTrack trackAdded');
    return false;
  });
});
