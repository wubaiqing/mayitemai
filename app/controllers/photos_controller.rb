class PhotosController < ApplicationController

  def create

    # 临时路径
    local_file = params[:Filedata].tempfile.path

    # 文件名
    file_name = SecureRandom.hex(13)

    # 文件扩展名称
    file_ext_name = File.extname(local_file)

    # 日期前缀
    file_prefix = DateTime.current().to_formatted_s(:number)

    # 七牛文件名称
    qiniu_file_name = file_prefix + "/" + file_name + file_ext_name

    # PUT 协议
    put_policy = Qiniu::Auth::PutPolicy.new(
      "mayitemai",
      qiniu_file_name
    )

    # 推送图片
    code, result, response_headers = Qiniu::Storage.upload_with_put_policy(
      put_policy,     # 上传策略
      local_file,     # 本地文件名
    )

    # 七牛图片地址
    render text: Setting.upload_url + "/" + qiniu_file_name

  end
end
