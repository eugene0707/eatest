class PhoneValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /^\+[0-9]+\([0-9]+\)[0-9]+\-[0-9]{3,}$/
      record.errors[attribute] << (options[:message] || record.errors.generate_message(attribute))
    end
  end
end
