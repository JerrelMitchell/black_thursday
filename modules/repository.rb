# :nodoc:
module Repository
  def inspect_instance(parent, instances)
    "#<#{parent.class} #{instances.size} rows>"
  end

  def find_with_id(instances, id)
    instances.find do |instance|
      instance.attributes[:id] == id
    end
  end

  def find_by_instance_string(instances, string, key)
    instances.find do |instance|
      instance.attributes[key].downcase.include?(string.downcase)
    end
  end

  def find_all_with_status(instances, status)
    instances.find_all do |instance|
      instance.status == status
    end
  end

  def find_all_with_instance_key(instances, value, key)
    instances.find_all do |instance|
      instance.attributes[key].eql?(value)
    end
  end

  def find_all_with_instance_string(instances, string, key)
    instances.find_all do |instance|
      instance.attributes[key].downcase.include?(string.downcase)
    end
  end

  def find_all_instances_in_price_range(instances, price_range)
    instances.find_all do |instance|
      price_range.include?(instance.attributes[:unit_price])
    end
  end

  def delete_instance(instances, id)
    instance = find_with_id(instances, id)
    instances.delete(instance)
  end

  def create_new_instance(instances, attributes, klass)
    new_id = (instances.map(&:id).max + 1)
    attributes[:id] = new_id
    assign_if_key_exists(attributes)
    instances << klass.new(attributes, self)
  end

  def assign_if_key_exists(attributes)
    if attributes.keys.any? do |key|
      ((key == :description || key == :merchant_id) || key == :result)
    end
      attributes[:created_at] = Time.now.to_s
      attributes[:updated_at] = Time.now.to_s
    end
  end

  def update_instance(id, attributes, instances, unchangeable_keys)
    instance = find_with_id(instances, id)
    return nil if instance.nil?
    attributes.each do |key, value|
      next if (attributes.keys & unchangeable_keys).any?
      change_attribute(instance, key, value)
    end
  end

  def change_attribute(instance, key, value)
    value = value.to_sym if instance.attributes.key?(:status)
    instance.attributes[key] = value if instance.attributes.keys.include?(key)
    assign_if_key_exists(instance.attributes)
    instance.attributes[:updated_at] = Time.now
  end
end
