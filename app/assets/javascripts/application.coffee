#= require jquery
#= require jquery_ujs
#= require jquery.turbolinks.min
#= require jquery.html5-fileupload

#= require tips
#= require turbolinks

#= require brands
#= require goods

# 开启Turbolinks
Turbolinks.enableProgressBar();

$(document).on 'page:change',  ->

  # 按钮提示
  $('a[data-toggle="tooltip"]').tipsy
    gravity: 's'

  $('ul.nav-sidebar > li').click ->
    $(this).addClass 'active'

