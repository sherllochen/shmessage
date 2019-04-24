module Shmessage
  class Engine < ::Rails::Engine
    isolate_namespace Shmessage

    config.to_prepare do
      # 载入engine对application的decorator
      Dir.glob(Engine.root.join("app", "decorators", "**", "*_decorator*.rb")).each do |c|
        require_dependency(c)
      end

      # 载入application对engine的decorator
      Dir.glob(Rails.root + "app/decorators/**/*_decorator*.rb").each do |c|
        require_dependency(c)
      end

      # Shmessage::Engine::ApplicationController.helper Rails.application.helpers
    end

    initializer "shmessage.url_helpers" do
      ActiveSupport.on_load(:action_controller) do
        helper Rails.application.routes.url_helpers
      end
    end
  end
end