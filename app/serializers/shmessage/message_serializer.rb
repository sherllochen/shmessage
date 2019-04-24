module Shmessage
  class MessageSerializer < ::BaseSerializer
    attributes :id, :title, :body, :updated_at, :target_role, :has_read

    def has_read
      !object.has_read_by?(scope)
    end

    def updated_at
      object.updated_at.strftime('%Y-%m-%d %H:%M:%S')
    end
  end
end