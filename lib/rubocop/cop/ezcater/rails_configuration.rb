# frozen_string_literal: true

module RuboCop
  module Cop
    module Ezcater
      class RailsConfiguration < Cop
        MSG = "Use `Rails.configuration` instead of `Rails.application.config`."
        RAILS_CONFIGURATION = "Rails.configuration"

        def_node_matcher "rails_application_config", <<-PATTERN
          (send (send (const _ :Rails) :application) :config)
        PATTERN

        def on_send(node)
          rails_application_config(node) do
            add_offense(node, location: :expression, message: MSG)
          end
        end

        def autocorrect(node)
          lambda do |corrector|
            corrector.replace(node.source_range, RAILS_CONFIGURATION)
          end
        end
      end
    end
  end
end
