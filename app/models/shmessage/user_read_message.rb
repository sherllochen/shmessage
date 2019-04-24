module Shmessage
  class UserReadMessage < ApplicationRecord
    belongs_to :user, class_name: Shmessage.config.user_class
    belongs_to :message, class_name: 'Shmessage::Message'
  end
end