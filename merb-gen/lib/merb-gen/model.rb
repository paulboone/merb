module Merb::ComponentGenerators
  
  class ModelGenerator < ComponentGenerator
    
    desc <<-DESC
      This is a model generator
    DESC
    
    option :testing_framework, :default => :spec, :desc => 'Specify which testing framework to use (spec, test_unit)'
    
    first_argument :name, :required => true
    second_argument :attributes, :as => :array
    
    template :model do
      source('model.rbt')
      destination('app/models/' + file_name + '.rb')
    end
    
    template :spec, :testing_framework => :spec do
      source('spec.rbt')
      destination('spec/models/' + file_name + '_spec.rb')
    end
    
    template :test_unit, :testing_framework => :test_unit do
      source('test_unit.rbt')
      destination('test/models/' + file_name + '_test.rb')
    end
    
    def class_name
      self.name.camel_case
    end
    
    def test_class_name
      self.class_name + "Test"
    end
    
    def file_name
      self.name.snake_case
    end
    
    def attributes?
      self.attributes && !self.attributes.empty?
    end
    
    def attributes_for_accessor
      self.attributes.map{|a| ":#{a}" }.compact.uniq.join(", ")
    end
    
    def source_root
      File.join(super, 'model')
    end
    
  end
  
  add :model, ModelGenerator
  
end