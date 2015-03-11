class Interpretation
  include Mongoid::Document
  field :name, type: String
  field :permalink, type: String
  field :language, type: String
end
