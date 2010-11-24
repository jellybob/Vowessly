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

  $('.expand a').live('click', function () {
    button = $(this).find('img')
    button.attr('src', button.attr('src').replace('expand', 'contract'))
    button.attr('title', 'View fewer details')
    $('.tipsy-inner').html(button.attr('title'))
    button.attr('alt', 'Contract')
    
    expand_div = button.parent().parent()
    fact_div = expand_div.parent()

    expand_div.removeClass('expand')
    expand_div.addClass('contract')
    
    fact_div.find('.metadata').slideDown()

    return false
  })

  $('.contract a').live('click', function () {
    button = $(this).find('img')
    button.attr('src', button.attr('src').replace('contract', 'expand'))
    button.attr('title', 'View more details')
    $('.tipsy-inner').html(button.attr('title'))
    button.attr('alt', 'Expand')

    contract_div = button.parent().parent()
    fact_div = contract_div.parent()

    contract_div.removeClass('contract')
    contract_div.addClass('expand')

    fact_div.find('.metadata').slideUp()

    return false
  })

  $('.new_fact_button').live('click', function () {
    $(this).hide()
    $('#new_fact').show()
    $('#new_fact #fact_label').focus()
  })

  $('#cancel_fact').live('click', function () {
    $('#new_fact').hide()
    $('.new_fact_button').show()
    $('#new_fact').find('input').each(function () { this.value = '' })
    return false;
  })

  $('.edit_fact').live('click', function () {
    fact = $('#' + $(this).attr('id').replace('edit_', ''))
    
    $.ajax({
      url: $(this).attr('href'),
      success: function (response) {
        $('.tipsy').hide()
        $(fact).html(response)
      }
    })

    return false
  })
  
  $('.edit_fact_form').live('submit', function () {
    form = $(this)
    fact_id = form.attr('id').replace('edit_fact_', '')

    $.ajax({
      url: form.attr('action'),
      type: form.attr('method'),
      data: form.serializeArray(),
      success: function (response) {
        fact = $('#fact_' + fact_id)
        fact.html(response)
      }
    })

    return false
  })

  $('.cancel_edit_fact').live('click', function () {
    fact_id = $(this).attr('id').replace('edit_fact_', '')

    $.ajax({
      url: document.location.pathname + '/facts/' + fact_id,
      success: function (response) {
        fact = $('#fact_' + fact_id)
        fact.html(response)
      }
    })
  })
})
