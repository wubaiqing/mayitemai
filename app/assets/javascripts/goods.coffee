# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).on 'page:change',  ->

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
    $('#fetch-taobao-repositories-hint').html('正在获取...');

    # 请求成功
    $.getJSON '/cpanel/goods/fetch_taobao_repositories', {taobao_id: $.trim(taobao_id)}, (jsonData)->
      data = jsonData.tbk_items_detail_get_response

      if (jsonData.status is '0')
        return $('#fetch-taobao-repositories-hint').html '商品已存在';

      if data.total_results is 0
        return $('#fetch-taobao-repositories-hint').html('数据返回空，或网络请求错误，请重试...');

      current = data.tbk_items.tbk_item['0']
      $('#fetch-taobao-repositories-hint').html(null);
      $('#good_taobao_url').val current.item_url
      $('#good_title').val current.title
      $('#good_original_price').val current.price
      $('#good_price').val current.discount_price
      $('#good_picture_url').val current.pic_url

  # 商品图片
  $("#goods-picture-upload").fileUpload
    url : "/cpanel/photos"
    type : "POST"
    beforeSend : ->
      $('#goods-picture-hint').html '上传中...'
    success : (result) ->
      $('#good_picture_url').val result
      $('#goods-picture-hint').html null;

  # 商品图片上传事件
  $("#goods_picture_add_image").click ->
    $("#goods-picture-upload").click()

  # 商品图片预览
  $('#goods_picture_review').click ->
    url = $('#good_picture_url').val()
    if url isnt ''
      window.open url
