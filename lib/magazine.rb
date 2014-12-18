require 'rails'
require 'hashie'

require 'magazine/engine'

module Magazine
  mattr_accessor :authorize_method_name
end
