module Shmessage
  class Message < ApplicationRecord
    # 目标角色ids,以_连接
    # :target_role
    mattr_accessor :author_class

    has_many :user_read_messages, class_name: 'Shmessage::UserReadMessage'
    belongs_to :author, class_name: Shmessage.config.author_class

    def self.unread
      result = all
      result = result.includes(:user_read_messages).where(shmessage_user_read_messages: {message_id: nil})
      return result
    end

    def self.create!(args)
      obj = new(args.except(:target_role))
      obj.target_role = args[:target_role].join('_')
      obj.save!
    end

    def update!(args)
      Message.transaction do
        update_attributes(args.except(:target_role))
        self.target_role = args[:target_role].join('_')
        save!
      end
    end

    def has_read_by?(user)
      return !user_read_messages.where(user: user).first.nil?
    end

    def read!(user)
      UserReadMessage.create!(user: user, message: self)
    end

    def target_role
      super.split('_').map {|item| item.to_i}
    end

    private
  end
end
