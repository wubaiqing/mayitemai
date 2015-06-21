#= require jquery
#= require jquery_ujs
#= require jquery.turbolinks.min
#= require turbolinks
#= require bootstrap-sprockets
#= require jquery.html5-fileupload
#= require nprogress
#= require tips
#= require brands
#= require goods

Turbolinks.enableProgressBar();

$(document).on 'page:change',  ->
  $('a[data-toggle="tooltip"]').tipsy
    gravity: 's'

  $('ul.nav-sidebar > li').click ->
    $(this).addClass 'active'

