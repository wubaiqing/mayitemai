# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ()->

  # 头部图片
  $("#banner-picture-upload").fileUpload
    url : "/photos"
    type : "POST"
    beforeSend : () ->
      $('#banner-upload-hint').html('上传中...');
    success : (result) ->
      $('#banner-picture-upload').val null
      $('#brand_banner_picture').val result
      $('#banner-upload-hint').html(null);



  # 推荐相关
  $("#recommend-picture-upload").fileUpload
    url : "/photos"
    type : "POST"
    beforeSend : () ->
      $('#recommend-upload-hint').html('上传中...');
    success : (result) ->
      $('#recommend-picture-upload').val null
      $('#brand_recommend_picture').val result
      $('#recommend-upload-hint').html(null);


  # 头部图片上传
  $("#banner_picture_add_image").click ()->
    $("#banner-picture-upload").click()


  # 头部图片上传
  $("#recommend_picture_add_image").click ()->
    $("#recommend-picture-upload").click()
