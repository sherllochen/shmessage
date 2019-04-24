require_dependency "shmessage/application_controller"

module Shmessage
  module Api
    module V1
      class MessagesController < ::Api::V1::BaseController
        before_action :set_message, only: [:show, :read, :update, :destroy]

        def show
          render json: @message
        end

        def index
          authorize Message
          @messages = policy_scope(Message.all)
          if !params[:unread].blank?
            @messages = @messages.unread
          end
          render json: @messages.order(updated_at: :desc)
        end

        def create
          authorize Message
          @message = Message.create!(message_params.merge(author: current_user))
          render json: @message
        end

        def update
          @message.update!(message_params)
          render json: @message
        end

        def read
          @message.read!(current_user)
          render_success
        end

        def destroy
          @message.destroy!
          render_success
        end

        private

        def set_message
          @message = Message.find_by_id(params[:id])
          if @message
            authorize @message
          else
            skip_authorization
            raise ArgumentError.new('record not found')
          end
        end

        def message_params
          params.require(:message).permit(:title, :body, :target_role => [])
        end
      end
    end
  end
end
