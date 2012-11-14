$('#searchSubmit').bind( 'click', function( e ) {
  alert( 'hoi' );
} );

$(document).ready(function() {

  $('.feedback-good').bind( 'click', function(e) {
    console.log( 'Good' );
    if( !$(this).hasClass('ui-icon-plus-green') ) {
      $(this).removeClass('ui-icon-plus').addClass('ui-icon-plus-green');
      var bad = $(this).siblings('.feedback-bad');
      if( bad.hasClass('ui-icon-minus-red') ) {
        bad.removeClass('ui-icon-minus-red').addClass('ui-icon-minus');
      } 
    } else {  
      $(this).removeClass('ui-icon-plus-green').addClass('ui-icon-plus');
    }
    return false;
  } );

  $('.feedback-bad').bind( 'click', function(e) {
    console.log( 'Bad' );
    if( !$(this).hasClass('ui-icon-minus-red') ) {
      $(this).removeClass('ui-icon-minus').addClass('ui-icon-minus-red');
      var good = $(this).siblings('.feedback-good');
      if( good.hasClass('ui-icon-plus-green') ) {
        good.removeClass('ui-icon-plus-green').addClass('ui-icon-plus');
      }
    } else {  
      $(this).removeClass('ui-icon-minus-red').addClass('ui-icon-minus');
    }

    return false;
  } );

$('#playlistItems').append( '<li data-role="collapsible" data-mini="true" data-collapsed-icon="arrow-r" data-expanded-icon="arrow-d" data-inset="false" data-content-theme="b">\
        <h2>\
          <span style="float: left;">Track C</span>\
          <span class="feedback-bad ui-icon ui-icon-minus" style="float: right"></span>\
          <span style="float: right">&nbsp;</span>\
          <span class="feedback-good ui-icon ui-icon-plus" style="float: right">&nbsp;</span>\
        </h2>\
        <ul>\
          <li>Album: <a href="index.html">Hoi</a></li>\
		      <li>Cover: <img src="" alt="cover" /></li>\
		      <li>Tags: <a href="index.html">A</a> <a href="index.html">B</a></li>\
			    <li>Feedback Score: + 2  - 1</a></li>\
		    </ul>\
	    </li>');
    $('#playlistItems ul li:first').listview('refresh', true);
  $('#playlistItems').bind('pageinit', function() {
    $('#playlistItems').listview('refresh');
  });

} );
