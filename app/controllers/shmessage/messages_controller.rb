require_dependency "shmessage/application_controller"

module Shmessage
  class MessagesController < ApplicationController
    before_action :set_message, only: [:show, :edit, :update, :destroy]

    # GET /messages
    def index
      authorize Message
      @messages = policy_scope(Message.all)
      if !params[:unread].blank?
        @messages = @messages.unread
      end
      @messages = paginate @messages.order(updated_at: :desc)
    end

    # GET /messages/1
    def show
      authorize @message
    end

    # GET /messages/new
    def new
      authorize Message
      @message = Message.new
    end

    # GET /messages/1/edit
    def edit
      authorize @message
    end

    # POST /messages
    def create
      authorize Message
      @message = Message.new(message_params)

      if @message.save
        redirect_to @message, notice: 'Message was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /messages/1
    def update
      authorize @message
      if @message.update(message_params)
        redirect_to @message, notice: 'Message was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /messages/1
    def destroy
      authorize @message
      @message.destroy
      redirect_to messages_url, notice: 'Message was successfully destroyed.'
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def message_params
      params.require(:message).permit(:title, :body, :author_id)
    end
  end
end
