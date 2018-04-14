
module Repository

  def find_all_attributes(business_attributes)
    business_attributes
  end

  def find_by_attribute_id(business_attributes, id)
    business_attributes.find do |business_attribute|
      business_attribute.id == id
    end
  end

  def find_by_attribute_name(business_attributes, name)
    business_attributes.find do |business_attribute|
      business_attribute.name.downcase == name.downcase
    end
  end

  def find_all_with_attribute_description(business_attributes, description)
    business_attributes.find_all do |business_attribute|
      business_attribute.description.downcase.include?(description.downcase)
    end
  end

  def find_all_by_attribute_price(business_attributes, price)
    business_attributes.find_all do |business_attribute|
      business_attribute.unit_price.eql?(price)
    end
  end

  def find_all_attributes_in_price_range(business_attributes, price_range)
    business_attributes.find_all do |business_attribute|
      price_range.include?(business_attribute.unit_price)
    end
  end

  def delete_attribute(business_attributes, id)
    binding.pry
    business_attributes.reject do |business_attribute|
      business_attribute.id == id
    end
  end



end
