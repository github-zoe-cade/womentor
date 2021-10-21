class FactoryHelper
  def self.create_with_traits_and_attributes(factory_class, evaluator, additional_attributes = {})
    params = Array.wrap(evaluator).compact.flatten
    traits = params.filter {|x| !x.is_a?(Hash)}
    attributes = {}
    params.filter {|x| x.is_a?(Hash)}.each{|h| attributes.merge!(h)}
    attributes.merge!(additional_attributes)
    traits_and_attributes = [*traits.presence, attributes].compact

    FactoryBot.create(factory_class, *traits_and_attributes)
  end
end
