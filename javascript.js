$('#searchSubmit').bind( 'click', function( e ) {
  alert( 'hoi' );
} );

$(document).ready(function() {

  $('.feedback-good').bind( 'click', function(e) {
    console.log( 'Good' );
    return false;
  } );

  $('.feedback-bad').bind( 'click', function(e) {
    console.log( 'Bad' );
    return false;
  } );

} );
