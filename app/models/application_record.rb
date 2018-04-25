class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end

class Integer

  def cents_to_dollars
    return '%.2f' % (self / 100.0)
  end

end
