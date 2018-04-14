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

  def create_new_instance(instances, attributes, klass)
    new_id = (instances.map(&:id).max + 1)
    attributes[:id] = new_id
    assign_if_key_exists(attributes)
    instances << klass.new(attributes, self)
  end

  def assign_if_key_exists(attributes)
    if attributes.keys.include?(:description || :unit_price)
      attributes[:created_at] = Time.now.to_s
      attributes[:updated_at] = Time.now.to_s
    end
  end




  def update_instance
    current_instance = find_by_id(id)
    change_all_requested_attributes(current_instance, attributes)
  end

  def change_all_requested_attributes(current_instance, attributes)
    attributes.each do |key, value|
      next if (attributes.keys & @unchangeable_keys).any?
      change_attribute(current_instance, key, value)
    end
  end

  def change_attribute(item, key, value)
    item.attributes[key] = value if item.attributes.keys.include?(key)
    assign_if_key_exists(attributes)
  end

end
