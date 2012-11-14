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

} );
