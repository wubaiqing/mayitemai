# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ()->

  opts =
    url : "/photos"
    type : "POST"
    beforeSend : () ->
      alert '123'
    success : (result, status, xhr) ->
      alert '444'
    error : (result, status, errorThrown) ->
      self.restoreUploaderStatus()
      alert(errorThrown)

  $("#banner-picture-upload").fileUpload opts

  # 头部图片上传
  $('#banner_picture_add_image').click ()->
    $('#banner-picture-upload').click()

