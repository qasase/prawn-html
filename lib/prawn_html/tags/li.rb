# frozen_string_literal: true

module PrawnHtml
  module Tags
    class Li < Tag
      ELEMENTS = [:li].freeze

      attr_reader :counter

      def block?
        true
      end

      def before_content
        return if @before_content_once

        @before_content_once = @counter ? "#{formatted_counter} " : "#{@symbol} "
      end

      def on_context_add(context)
        case parent.class.to_s
        when 'PrawnHtml::Tags::Ol'
          @counter = (parent.counter += 1)
          @parent_counters = context.select { |element| element.tag == :li && element != self }.map(&:counter)
        when 'PrawnHtml::Tags::Ul'
          @symbol = parent.styles[:list_style_type] || '&bullet;'
        end
      end

      private

      def formatted_counter
        return "#{@counter}." if @parent_counters.blank?

        (@parent_counters + [@counter]).compact.join('.')
      end
    end
  end
end
