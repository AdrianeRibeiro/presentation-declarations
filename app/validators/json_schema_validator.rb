class JsonSchemaValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    schema = options.fetch(:schema)
    schema = schema.call(record) if schema.respond_to?(:call)
    return if schema.nil?

    schema.validate(value.as_json).each do |error|
      message = format('%s: %s', error['data_pointer'], error['error'] || error['type'])
      record.errors.add(attribute, :invalid, message: message)
    end
  end
end
