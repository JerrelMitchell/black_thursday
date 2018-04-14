# :nodoc:
module Repository

  def find_all_instances(instances)
    instances
  end

  def find_by_instance_id(instances, id)
    instances.find do |instance|
      instance.attributes[:id] == id
    end
  end

  def find_by_instance_name(instances, name)
    instances.find do |instance|
      instance.attributes[:name].downcase == name.downcase
    end
  end

  def find_all_with_instance_description(instances, description)
    instances.find_all do |instance|
      instance.attributes[:description].downcase.include?(description.downcase)
    end
  end

  def find_all_by_instance_price(instances, price)
    instances.find_all do |instance|
      instance.attributes[:unit_price].eql?(price)
    end
  end

  def find_all_instances_in_price_range(instances, price_range)
    instances.find_all do |instance|
      price_range.include?(instance.attributes[:unit_price])
    end
  end

  def delete_instance(instances, id)
    instance = find_by_instance_id(instances, id)
    instances.delete(instance)
  end

end
