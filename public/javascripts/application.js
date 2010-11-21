// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function()
{
  // jQuery datepicker for formtastic (see http://gist.github.com/271377)
  $('input.ui-datepicker').datepicker({ dateFormat: 'dd-mm-yy' });

  // Tooltips (see http://onehackoranother.com/projects/jquery/tipsy)
  $('img').each( function() {
    if ($(this).get(0).title != '') {
      gravity = $(this).attr('data-gravity') || 'n';
      $(this).tipsy({ gravity: gravity });
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

  $('.expand img').live('click', function () {
    button = $(this)
    button.attr('src', button.attr('src').replace('expand', 'contract'))
    button.attr('title', 'View fewer details')
    $('.tipsy-inner').html(button.attr('title'))
    button.attr('alt', 'Contract')

    button.parent().removeClass('expand')
    button.parent().addClass('contract')
    
    button.parent().parent().find('.metadata').slideDown()
  })

  $('.contract img').live('click', function () {
    button = $(this)
    button.attr('src', button.attr('src').replace('contract', 'expand'))
    button.attr('title', 'View more details')
    $('.tipsy-inner').html(button.attr('title'))
    button.attr('alt', 'Expand')

    button.parent().removeClass('contract')
    button.parent().addClass('expand')

    button.parent().parent().find('.metadata').slideUp()
  })

  $('.new_fact_button').live('click', function () {
    $(this).hide()
    $('#new_fact').show()
  })

  $('#cancel_fact').live('click', function () {
    $('#new_fact').hide()
    $('.new_fact_button').show()
    $('#new_fact').find('input').each(function () { this.value = '' })
    return false;
  })
})
