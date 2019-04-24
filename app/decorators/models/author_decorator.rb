Shmessage.config && Shmessage.config.author_class && Shmessage.config.author_class.constantize.class_eval do
  # 创建的站内信
  has_many :created_messages, class_name: "Shmessage::Message", foreign_key: 'author_id'
end