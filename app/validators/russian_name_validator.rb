class RussianNameValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /^([а-я]+)( [а-я]+){2}$/i
      record.errors[attribute] << (options[:message] || record.errors.generate_message(attribute))
    end
  end
end
