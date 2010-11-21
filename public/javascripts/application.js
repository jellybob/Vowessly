// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function()
{
  // jQuery datepicker for formtastic (see http://gist.github.com/271377)
  $('input.ui-datepicker').datepicker({ dateFormat: 'dd-mm-yy' });

  // Tooltips (see http://onehackoranother.com/projects/jquery/tipsy)
  $('img').each( function() {
    if ($(this).get(0).title != '') {
      $(this).tipsy();
    }
  });
});

// Scroll effect for anchors
jQuery(function( $ )
{
	$('a').click(function() {
	   if ($(this).attr('class') == 'anchor') {
		   $.scrollTo(this.hash, 500);
		   $(this.hash).find('span.message').text(this.href);
		   return false;
	   }
	});
});

$(function () {
  $('.inner .body a[href^="/pages/new"]').each(function () {
    $(this).addClass('unresolved')
    $(this).attr('title', 'Click to create this page.')
    $(this).tipsy();
  })

  $('.inner .body table').each(function () {
    $(this).addClass('table')
  })
})
