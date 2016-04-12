# 专题
$(document).on 'page:change',  ->

  # 上传图片 - 品牌Logo
  $("#article_picture_add_image").click ->
    Mayi.uploadPircture "#article-picture-upload", "#article-picture-hint", "#article_picture_url"



