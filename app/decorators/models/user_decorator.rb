Shmessage.config && Shmessage.config.user_class && Shmessage.config.user_class.constantize.class_eval do
  # 能够接受到的站内信
  def messages
    Shmessage::Message.where('target_role is null OR target_role LIKE ?', "%#{self.role.id}%")
  end

  # 未读信息
  def unread_messages
    messages.includes(:shmessage_use_read_messages).where(shmessage_use_read_messages: {message_id: nil})
  end
end