json.array!(@cpanel_haos) do |cpanel_hao|
  json.extract! cpanel_hao, :id
  json.url cpanel_hao_url(cpanel_hao, format: :json)
end
