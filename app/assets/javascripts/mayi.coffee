# 上传图片
uploadPircture = (id, hint, result)->
  # jQuery上传插件
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
reviewPircture = (id)->
  url = $(id).val()
  if url isnt ''
    window.open url


# 公用类
@Mayi =
  'uploadPircture': uploadPircture
  'reviewPircture': reviewPircture
