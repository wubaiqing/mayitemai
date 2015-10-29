# json.ignore_nil!
json.array!(@haos) do |hao, h|
  json.long_title hao["title"]
  json.identify hao["taobao_id"]
  json.url hao["taobao_url"]
  json.img_url hao["picture_url"]
  json.price hao["original_price"]
  json.site hao["site"]
  json.site_url hao["site_url"]
  json.wapurl ""
  json.cheap '0'.to_i
  json.site_url hao["site_url"]
  json.tagid hao["tagid"]
  json.tag Hao.findTag(hao["tagid"])
  json.post hao["post"]
  json.price_new hao["price"]
end
