#= require mayi

#= require jquery
#= require jquery_ujs
#= require jquery.turbolinks.min
#= require jquery.html5-fileupload

#= require tips
#= require turbolinks

#= require brands
#= require goods
#= require haos

#= require ueditor/ueditor.config
#= require ueditor/ueditor.all.min

# 开启Turbolinks
Turbolinks.enableProgressBar();


$(document).on 'page:change',  ->

  # 按钮提示
  $('a[data-toggle="tooltip"]').tipsy
    gravity: 's'

  # 左侧导航点击事件
  $('ul.nav-sidebar > li').click ->
    $(this).addClass 'active'


