class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    includes(boats: :classifications).where("classifications.name = 'Catamaran'")
  end

  def self.sailors
    includes(boats: :classifications).where("classifications.name = 'Sailboat'").distinct
  end

  def self.talented_seamen
    motorboats = joins(boats: :classifications).where("classifications.name = 'Motorboat'")
    where('ID in (?)', self.sailors.pluck(:id) & motorboats.pluck(:id))
  end

  def self.non_sailors
    where.not('ID in (?)', self.sailors.pluck(:id))
  end

end

#Model.joins(:another_model_table_name)
#.where('another_model_table_name.id IN (?)', your_id_array)
#source:
#https://stackoverflow.com/questions/12176102/what-is-the-difference-between-pluck-and-collect-in-rails
