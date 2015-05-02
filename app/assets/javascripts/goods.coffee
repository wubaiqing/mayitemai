# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).on 'page:change',  ->
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

    # 请求成功
    $.getJSON('/goods/fetch_taobao_repositories', {taobao_id: $.trim(taobao_id)}, (jsonData)->
      if jsonData is null
        return alert '数据返回为空'
      else
        $('#good_taobao_url').val jsonData.item_url
        $('#good_title').val jsonData.title
        $('#good_original_price').val jsonData.price
        $('#good_picture_url').val jsonData.pic_url
    )
