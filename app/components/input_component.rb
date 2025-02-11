class InputComponent < ViewComponent::Base
  attr_reader :type, :name, :id, :label, :value, :form, :opts,
    :wr_opts, :lb_opts

  def initialize(type: nil, name: nil, form: nil, label: nil, value: nil, opts: {})
    @form = form
    @type = type.to_s.downcase
    @name = name
    @id = id || name.to_s
    @label = opts.delete(:label) || name.to_s.humanize
    @value = value || form&.object&.send(name)
    @lb_opts = opts.delete(:lb_opts) || {}
    @wr_opts = opts.delete(:wr_opts)
    @opts = opts
  end

  def call
    render_wrapper do
      concat(render_label) if %w(email number text text_area password).include?(type)
      concat(render_input)
    end
  end

  private

    def render_label
      content_tag(:label, label, for: label)
    end

    def render_wrapper(&block)
      content_tag(:div, class: "form-group", &block)
    end

    def textarea
      form.text_area(name, **opts.merge(class: "form-control"))
    end

    def checkbox
      form.check_box(name, opts, value, nil)
    end

    def radio
      form.radio_button(name, value, **opts)
    end

    def text
      form.text_field(name, **opts.merge(class: "form-control"))
    end

    def combobox
      form.combobox(name, value, **opts)
    end

    def password
      form.password_field(name, **opts.merge(class: "form-control"))
    end

    def hidden
      form.hidden_field(name, **opts)
    end

    def submit
      form.submit(name, **opts.merge(class: "btn btn-primary"))
    end

    def email
      form.email_field(name, **opts.merge(class: "form-control"))
    end

    def number
      form.number_field(name, **opts.merge(class: "form-control"))
    end


    def render_input
      case type.to_s.downcase
      when "combobox"
        combobox
      when "textarea"
        textarea
      when "checkbox"
        checkbox
      when "radio"
        radio
      when "password"
        password
      when "hidden"
        hidden
      when "submit"
        submit
      when "email"
        email
      when "number"
        number
      else
        text
      end
    end

    def custom_wrapper?
      wr_opts.present?
    end
end
