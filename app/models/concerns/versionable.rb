module Versionable
  extend ActiveSupport::Concern

  class_methods do
    def versioning_by_who(whodunnit)
      PaperTrail::Version.where(whodunnit: whodunnit)
        .order('versions.created_at desc')
    end
    alias v_who versioning_by_who

    def versioning_by_item_type(item_type)
      PaperTrail::Version.where(item_type: item_type).includes(:item)
        .order('versions.created_at desc')
    end
    alias v_item_type versioning_by_item_type

    def readable_object(version)
      return {} unless version&.object&.present?

      parsed_object = YAML
        .safe_load(version.object,
                   permitted_classes: [ActiveSupport::TimeWithZone,
                                       Time,
                                       ActiveSupport::TimeZone],
                   aliases: true)
      human_readable_object = process_special_objects(parsed_object)
      parsed_object.with_indifferent_access
    end

    private

    def process_special_objects(data)
      case data
      when Hash
        data.each_with_object({}) do |(key, value), result|
          result[key] = process_special_objects(value)
        end
      when Array
        data.map { |item| process_special_objects(item) }
      when ActiveSupport::TimeWithZone
        data.iso8601
      else
        data
      end
    end
  end
end
