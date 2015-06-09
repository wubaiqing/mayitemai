# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'page:change',  ->

  # Logo图片
  $("#logo-picture-upload").fileUpload
    url : "/cpanel/photos"
    type : "POST"
    beforeSend : ->
      $('#logo-picture-hint').html '上传中...'
    success : (result) ->
      $('#brand_logo_picture').val result
      $('#logo-picture-hint').html null

  # 首页图片
  $("#desc-picture-upload").fileUpload
    url : "/cpanel/photos"
    type : "POST"
    beforeSend : ->
      $('#desc-picture-hint').html '上传中...'
    success : (result) ->
      $('#brand_desc_picture').val result
      $('#desc-picture-hint').html null

  # 专题顶部图片
  $("#banner-picture-upload").fileUpload
    url : "/cpanel/photos"
    type : "POST"
    beforeSend : ->
      $('#banner-picture-hint').html '上传中...'
    success : (result) ->
      $('#brand_banner_picture').val result
      $('#banner-picture-hint').html null;


  # 品牌Logo
  $("#logo_picture_add_image").click ->
    $("#logo-picture-upload").click()

  # 首页
  $("#desc_picture_add_image").click ->
    $("#desc-picture-upload").click()

  # 专题页顶部
  $("#banner_picture_add_image").click ->
    $("#banner-picture-upload").click()



  # 品牌预览
  $('#logo_picture_review').click ->
    url = $('#brand_logo_picture').val()
    if url isnt ''
      window.open url

  # 首页预览
  $('#desc_picture_review').click ->
    url = $('#brand_desc_picture').val()
    if url isnt ''
      window.open url

  # 专题页顶部预览
  $('#banner_picture_review').click ->
    url = $('#brand_banner_picture').val()
    if url isnt ''
      window.open url

