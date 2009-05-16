require 'active_support'

module Machinist
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    def blueprint(name = :default, &blueprint)
      @blueprints ||= {}
      if blueprint then @blueprints[name] = blueprint end
      @blueprints[name]
    end
  
    def make(blueprint_name = :default, attributes = {}, require_valid = true)
      if !blueprint_name.is_a?(Symbol)
        attributes     = blueprint_name
        blueprint_name = :default
      end

      blueprint = blueprint(blueprint_name)
      raise "No blueprint #{blueprint_name.inspect} for class #{self}" if blueprint.nil?
      lathe = Lathe.new(self.new, attributes)
      lathe.instance_eval(&blueprint)
      lathe.save_object(require_valid)
    end

    def make!(blueprint_name = :default, attributes = {})
      make(blueprint_name, attributes, false)
    end
  end
  
  class Lathe
    def initialize(object, attributes)
      @object = object
      @assigned_attributes = []
      attributes.each do |key, value|
        @object.send("#{key}=", value)
        @assigned_attributes << key
      end
    end

    attr_reader :object

    def save_object(require_valid = true)
      if require_valid
        @object.save!
      else
        @object.save
      end
      @object.reload unless @object.new_record?
      @object
    end

    def method_missing(symbol, *args, &block)
      if @assigned_attributes.include?(symbol)
        @object.send(symbol)
      else
        value = if block
          block.call
        elsif args.first.is_a?(Hash) || args.empty?
          symbol.to_s.camelize.constantize.make(args.first || {})
        else
          args.first
        end
        @object.send("#{symbol}=", value)
        @assigned_attributes << symbol
      end
    end
  end
end
