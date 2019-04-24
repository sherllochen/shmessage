module Shmessage::Concerns::Models::Message
  extend ActiveSupport::Concern

  included do
    mattr_accessor :author_class
    belongs_to :author, class_name: Message.author_class

    attr_accessor :author_name

    before_validation :set_author

    private

    def set_author
      self.author = Message.constantize.find_or_create_by(name: author_name)
    end
  end

  module ClassMethods
    def some_class_method
      'some class method string'
    end
  end
end