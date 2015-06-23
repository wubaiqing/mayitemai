# coding: utf-8
# 基本 Model，加入一些通用功能
module Mongoid
  # BaseModel
  module BaseModel
    extend ActiveSupport::Concern

    module ClassMethods
      # like ActiveRecord find_by_id
      def find_by_id(id)
        if id.is_a?(Integer) || id.is_a?(String)
          where(_id: id.to_i).first
        else
          nil
        end
      end
    end

  end
end
