# json.ignore_nil!
json.array!(@haos) do |hao, h|
  json.long_title hao["long_title"]
  json.identify hao["identify"]
  json.url hao["url"]
  json.img_url hao["img_url"]
  json.price hao["price"]
  json.site hao["site"]
  json.site_url hao["site_url"]
  json.wapurl ""
  json.cheap '0'.to_i
  json.site_url hao["site_url"]
  json.tagid hao["tagid"]
  json.tag hao["tag"]
  json.post hao["post"]
end
