function rebindFeedback( ) {
  $('.feedback-good').unbind('click').bind( 'click', function(e) {
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

  $('.feedback-bad').unbind('click').on( 'click', function(e) {
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
}

var data = new function( ) {
  this.playlist = new Array();
  this.searchlist = new Array();
  
  this.pushPlaylist = function( track, isNewTrack ) {
    isNewTrack = typeof isNewTrack !== 'undefined' ? isNewTrack : true;

    //console.log( $('#playlistItems') );
    this.playlist.push( track );
    $('#playlistItems').append( '<li data-role="collapsible" data-mini="true" data-collapsed-icon="arrow-r" data-expanded-icon="arrow-d" data-inset="false" data-content-theme="b">\
          <h2>\
            <span style="float: left;">' + track.artist +' &ndash; ' + track.title + '</span>\
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
    $( "#playlistItems" ).collapsibleset( "refresh" );
    rebindFeedback();

    if( isNewTrack ) {
      var newTrack = $('#playlistItems li:last-child a').addClass('ui-btn-active');
      setTimeout( function() { 
        newTrack.removeClass('ui-btn-active');
      }, 3000 );
    }
  }

  this.pushSearchlist = function( track ) {
    this.searchlist.push( track );
    $('#resultItems').append( '<li data-role="collapsible" data-mini="true" data-collapsed-icon="arrow-r" data-expanded-icon="arrow-d" data-inset="false" data-content-theme="b">\
          <h2 class="active">\
            <span style="float: left;">' + track.artist +' &ndash; ' + track.title + '</span>\
            <span class="addTrack ui-icon ui-icon-plus" style="float: right">&nbsp;</span>\
          </h2>\
          <ul>\
            <li>Album: <a href="index.html">Hoi</a></li>\
		        <li>Cover: <img src="" alt="cover" /></li>\
		        <li>Tags: <a href="index.html">A</a> <a href="index.html">B</a></li>\
			      <li>Feedback Score: + 2  - 1</a></li>\
		      </ul>\
	      </li>');
      //$( "#resultItems" ).collapsibleset( "refresh" );
  }
}

//console.log( data );





$(document).ready(function() {
  /* rebindFeedback();


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

    $( "#playlistItems" ).collapsibleset( "refresh" );
    rebindFeedback(); */

    /*
    console.log( $( '#resultItems' ) );
    $( '#resultItems li:last h2' ).removeClass('ui-corner-bottom');
    $( '#resultItems' ).append('<li class="ui-collapsible" data-role="mlist">\
        <h2 class="ui-collapsible-heading ui-mini ui-btn ui-btn-up-c ui-corner-bottom">\
            <span class="ui-btn-inner">\
              Track B\
             </span>\
        </h2>\
	    </li>');
    */

    //$('#resultItems').mlistset('refresh');

    /*
    $( '#resultItems' ).children('li').find( "h2" )
					.first()
					.addClass( "ui-corner-top" )
					.find( ".ui-btn-inner" )
						.addClass( "ui-corner-top" ).
           
          find( "h2" )
					.first()
					.addClass( "ui-corner-bottom" )
					.find( ".ui-btn-inner" )
						.addClass( "ui-corner-bottom" ); */


} );

/* 
function addTrack( track ) {
  $('#playlistItems').append( '<li data-role="collapsible" data-mini="true" data-collapsed-icon="arrow-r" data-expanded-icon="arrow-d" data-inset="false" data-content-theme="b">\
        <h2 class="active">\
          <span style="float: left;">Nieuwe track ' + track +'</span>\
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
    //$( "#playlistItems" ).collapsibleset( "refresh" );
    rebindFeedback();
    //var newTrack = $('#playlistItems .active a').addClass('ui-btn-active').parent().removeClass('active');
    var newTrack = $('#playlistItems .active a').addClass('ui-btn-active');
    newTrack.parent().removeClass('active');
    setTimeout( function() { 
         //$('#playlistItems .ui-btn-active').removeClass('ui-btn-active')
         newTrack.removeClass('ui-btn-active');
    }, 3000 );
    //window.location = '#playlist';
} */

$( '#playlist' ).live( 'pageinit', function( event ) {
  //console.log( '#playlist' );
  data.pushPlaylist( { 
    spotify: "123",
    artist: "Nitrous Oxide",
    title: "Alderaan"
  }, false );

  data.pushPlaylist( { 
    spotify: "123",
    artist: "Nitrous Oxide",
    title: "North Pole (Album Edit)"
  }, false );

  data.pushPlaylist( { 
    spotify: "123",
    artist: "Nitrous Oxide",
    title: "Mirror's Edge"
  }, false );

  data.pushPlaylist( { 
    spotify: "123",
    artist: "Nitrous Oxide",
    title: "Follow You Ft. Aneym"
  }, false );

  data.pushPlaylist( { 
    spotify: "123",
    artist: "Nitrous Oxide",
    title: "Muriwai"
  }, false );

  data.pushSearchlist( {
    spotify: "123",
    artist: "Nitrous Oxide",
    title: "Blurry Motion"
  } );

  data.pushSearchlist( {
    spotify: "123",
    artist: "Nitrous Oxide",
    title: "Downforce"
  } );

} );

$( '#addTrack' ).live( 'pagebeforecreate',function(event){

  $('#searchSubmit').bind('click', function(e) {
    /*      
    $( '#resultItems li:last h2' ).removeClass('ui-corner-bottom');
    $( '#resultItems' ).append('<li class="ui-collapsible" data-role="mlist">\
        <h2 class="ui-collapsible-heading ui-mini ui-btn ui-btn-up-c ui-corner-bottom">\
            <span class="ui-btn-inner">' + $('#search-basic').val() +'</span>\
        </h2>\
	    </li>');
    $('#resultItems').css('visibility', 'visible');
    $('#resultItems li h2').unbind('click').bind('click', function(e) {
      addTrack( $(this).children('h2 span').text() );
    }); */

    $('#resultItems').css('visibility', 'visible');
    $('#resultItems li h2 .addTrack').unbind('click').bind('click', function(e) {
      //addTrack( $(this).parent().children().first().text() );
      //console.log( data.playlist );

      data.pushPlaylist( data.searchlist[$(this).parent().parent().parent().parent().parent().index()] );
      $(this).removeClass('addTrack').removeClass('ui-icon-plus').addClass('ui-icon-none');
      return false;

    });

  });


  $('#resultItems li h2 .addTrack').bind('click', function(e) {
    console.log( 'hoi', $(this).parent().children().first() );
    //addTrack( $(this).parent().children().first().text() );
    data.pushPlaylist( data.searchlist[$(this).parent().parent().parent().parent().parent().index()] );
    $(this).removeClass('ui-icon-plus').addClass('ui-icon-none');
    return false;
  });


});


$( '#getSuggestions' ).live( 'pagebeforecreate',function(event){

  

});
