module WhitespaceStripper
  extend ActiveSupport::Concern

  module ClassMethods
    def strip_whitespace(*fields)
      fields.each do |field|
        define_method("#{field}_with_whitespace_stripping=") do |value|
          value.strip! if value
          send("#{field}_without_whitespace_stripping=", value)
        end
        alias_method_chain "#{field}=", :whitespace_stripping
      end
    end
  end
end
