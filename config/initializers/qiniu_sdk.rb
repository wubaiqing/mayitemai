require 'qiniu'

Qiniu.establish_connection! :access_key => Setting.qiniu_access_key,
                            :secret_key => Setting.qiniu_secret_key

