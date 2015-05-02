#= require jquery
#= require jquery_ujs
#= require jquery.turbolinks.min
#= require turbolinks
#= require bootstrap-sprockets
#= require jquery.html5-fileupload
#= require nprogress
#= require brands
#= require goods

Turbolinks.enableProgressBar();

$(document).on 'page:change',  ->
  $('ul.nav-sidebar > li').click ->
    $(this).addClass 'active'
