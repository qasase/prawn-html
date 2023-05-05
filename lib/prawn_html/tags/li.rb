# frozen_string_literal: true

module PrawnHtml
  module Tags
    class Li < Tag
      ELEMENTS = [:li].freeze

      def block?
        true
      end

      def before_content
        return if @before_content_once

        @before_content_once = @counter ? "#{@counter}. " : "#{@symbol} "
      end

      def on_context_add(_context)
        case parent.class.to_s
        when 'PrawnHtml::Tags::Ol'
          @counter = (parent.counter += 1)
        when 'PrawnHtml::Tags::Ul'
          @symbol = parent.styles[:list_style_type] || '&bullet;'
        end
      end
    end
  end
end
