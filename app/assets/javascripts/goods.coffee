# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).on 'page:change',  ->

  # 商品图片上传事件
  $("#goods_picture_add_image").click ->
    Mayi.uploadPircture "#goods-picture-upload", "#goods-picture-hint", "#good_picture_url"


  # 商品图片预览
  $('#goods_picture_review').click ->
    Mayi.reviewPircture "#good_picture_url"


  # 获取淘宝商品
  $('#fetch_taobao_repositories').click ->

    # 淘宝ID
    taobao_id = $('#good_taobao_id').val()

    # ID为空
    if taobao_id == ''
      $('#good_taobao_url').val null
      $('#good_title').val null
      $('#good_original_price').val null
      $('#good_picture_url').val null
      return alert '请填写淘宝ID'

    # 提示
    $('#fetch-taobao-repositories-hint').html '正在获取...'

    # 请求成功
    $.getJSON '/cpanel/goods/fetch_taobao_repositories', {taobao_id: $.trim(taobao_id)}, (jsonData)->
      data = jsonData.tbk_items_detail_get_response

      if (jsonData.errorCode is 10001)
        return $('#fetch-taobao-repositories-hint').html '商品在数据库中存在'

      if data.total_results is 0
        return $('#fetch-taobao-repositories-hint').html '请求淘宝API时，数据返回为空'

      # 当前数据
      current = data.tbk_items.tbk_item['0']

      $('#fetch-taobao-repositories-hint').html null
      $('#good_taobao_url').val current.item_url
      $('#good_title').val current.title
      $('#good_original_price').val current.price

      # 价格校验
      if current.discount_price.substr(-2, 1) is 0
        discount_price = parseInt current.discount_price
      else
        discount_price = current.discount_price

      $('#good_price').val parseInt(current.discount_price)
      $('#good_picture_url').val current.pic_url + '_400x400.jpg'
