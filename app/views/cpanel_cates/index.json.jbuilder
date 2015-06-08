json.array!(@cpanel_cates) do |cpanel_cate|
  json.extract! cpanel_cate, :id
  json.url cpanel_cate_url(cpanel_cate, format: :json)
end
