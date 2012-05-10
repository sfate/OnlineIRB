class EvalData
  attr_accessor :ready, :id, :respond

  def initialize(options={})
    @ready = false
    @id    = options[:id]
  end

  def self.find(id)
    found = nil
    ObjectSpace.each_object(self) do |obj|
      found = obj if obj.id == id
    end
    found
  end
end

