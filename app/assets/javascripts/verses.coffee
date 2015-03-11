# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  $(document).on 'affix.bs.affix', (e) ->
    $(e.target).addClass('animated fadeInDown')
    $('body').css('margin-top', '250px');
  $(document).on 'affixed-top.bs.affix', (e) ->
    $(e.target).removeClass('animated fadeInUp')
  $(document).on 'affix-top.bs.affix', (e) ->
    $('body').css('margin-top', '0')
    $(e.target).removeClass('animated fadeInDown')
    $(e.target).addClass('animated fadeInUp')
    $('body').css('margin-top', '0');
