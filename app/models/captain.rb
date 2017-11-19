class Captain < ActiveRecord::Base
  has_many :boats
  has_many :boat_classifications, through: :boats
  has_many :classifications, through: :boat_classifications

  def self.catamaran_operators
    self.joins(:boats).joins(:boat_classifications).joins(:classifications).where("classifications.name = 'Catamaran'").distinct
  end

  def self.sailors
    self.joins(:boats).joins(:boat_classifications).joins(:classifications).where("classifications.name = 'Sailboat'").distinct
  end

  def self.motorboats
    self.joins(:boats).joins(:boat_classifications).joins(:classifications).where("classifications.name = 'Motorboat'").distinct
  end

  def self.talented_seamen
    self.where("id in (?)", self.sailors.select(:id) & self.motorboats.select(:id)) 
  end

  def self.non_sailors
    self.where("id NOT in (?)", self.sailors.select(:id))
  end

end
