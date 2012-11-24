// Generated by CoffeeScript 1.3.3
var playlistData, suggestionData;

playlistData = [
  {
    artist: 'Nitrous Oxide',
    title: 'Alderaan'
  }, {
    artist: 'Nitrous Oxide',
    title: 'Alderaan 2'
  }
];

suggestionData = [
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
  return $.link.playlistItem('#playlistItems', playlistData);
});

$('#getSuggestions').live('pagebeforecreate', function() {
  $('#suggestionItems .addTrack').live('click', function(e) {
    $(this).toggleClass('addTrack trackAdded');
    return false;
  });
  $.templates({
    suggestionItem: '#suggestionItem'
  });
  return $.link.suggestionItem('#suggestionItems', suggestionData);
});
