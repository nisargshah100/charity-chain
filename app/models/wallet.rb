class Wallet < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :goal
  monetize :amount_cents

  def increase
    self.amount_cents += 100
    self.save()
  end
end
