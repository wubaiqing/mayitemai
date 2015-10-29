# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).on 'page:change',  ->


  # 商品图片上传事件
  $("#haos_picture_add_image").click ->
    Mayi.uploadPircture "#haos-picture-upload", "#haos-picture-hint", "#hao_picture_url"


  # 商品图片预览
  $('#haos_picture_review').click ->
    Mayi.reviewPircture "#hao_picture_url"


  # 淘宝链接查看
  $('#look_url').click ->
    curl = $('#hao_taobao_url').val()
    return false if curl is ''
    window.open curl


  # 淘宝链接查看
  $('#look_site_url').click ->
    curl = $('#hao_site_url').val()
    return false if curl is ''
    window.open curl


  # 获取淘宝商品
  $('#hao123_fetch_taobao_repositories').click ->

    # 淘宝ID
    taobao_id = $('#hao_taobao_id').val()

    # ID为空
    if taobao_id == ''
      $('#hao_taobao_id').val null
      $('#hao_title').val null
      $('#hao_original_price').val null
      $('#hao_picture_url').val null
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
      $('#hao_taobao_url').val current.item_url
      $('#hao_title').val current.title

      # 价格校验
      if current.discount_price.substr(-2, 1) is '0'
        discount_price = parseInt current.discount_price
      else
        discount_price = current.discount_price

      # 价格校验
      if current.price.substr(-2, 1) is '0'
        price = parseInt current.price
      else
        price = current.price

      $('#hao_original_price').val price
      $('#hao_price').val discount_price

      $('#hao_picture_url').val current.pic_url + '_400x400.jpg'
      $('#hao_site').val current.nick
      $('#hao_site_url').val current.shop_url

