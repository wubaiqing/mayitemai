# 专题
$(document).on 'page:change',  ->

  # 上传图片 - 品牌Logo
  $("#logo_picture_add_image").click ->
    uploadPircture "#logo-picture-upload", "#logo-picture-hint", "#brand_logo_picture"


  # 上传图片 - 首页图片
  $("#desc_picture_add_image").click ->
    uploadPircture "#desc-picture-upload", "#desc-picture-hint", "#brand_desc_picture"


  # 上传图片 - 专题页顶部
  $("#banner_picture_add_image").click ->
    uploadPircture "#banner-picture-upload", "#banner-picture-hint", "#brand_desc_picture"


  # 图片预览 - 品牌预览
  $('#logo_picture_review').click ->
    reviewPircture "#brand_logo_picture"


  # 图片预览 - 首页预览
  $('#desc_picture_review').click ->
    reviewPircture "#brand_desc_picture"


  # 图片预览 - 专题页顶部预览
  $('#banner_picture_review').click ->
    reviewPircture "#brand_banner_picture"


  # 上传图片
  uploadPircture = (id, hint, result)->
    $(id).fileUpload
      url : "/cpanel/photos"
      type : "POST"
      beforeSend : ->
        $(hint).html '上传中...'
      success : (url) ->
        $(result).val url
        $(hint).html null

    $(id).click()


  # 预览图片
  reviewPircture = (id)
    url = $('#brand_desc_picture').val()
    if url isnt ''
      window.open url
