module ApplicationHelper

  def bs_alert(message, type = 'success')
    if message.present?
      content_tag(:div, class: "alert alert-#{type} alert-dismissible fade show", role: 'alert') do
        concat(message)
        concat(button_tag(type: 'button', class: 'btn-close', data: { bs_dismiss: 'alert' }, aria: { label: 'Close' }) do
          content_tag(:span, '&times;'.html_safe)
        end)
      end
    end
  end

  def bs_button_to(name, path, method: :get, type: 'primary')
    button_to name, path, method: method, class: "btn btn-#{type}"
  end

  def bs_link_to(name, path, color: 'primary')
    link_to name, path, class: "link-#{color}"
  end

  def navigation_bar(items)
    content_tag(:nav, class: 'navbar navbar-expand-lg navbar-light bg-light') do
      concat(navbar_brand)
      concat(navbar_toggler)
      concat(navbar_collapse(items))
    end
  end

  private

  def navbar_brand
    content_tag(:a, 'MyApp', class: 'navbar-brand', href: '#')
  end

  def navbar_toggler
    button_tag(class: 'navbar-toggler', type: 'button', data: { toggle: 'collapse', target: '#navbarNav' }, aria: { controls: 'navbarNav', expanded: 'false', label: 'Toggle navigation' }) do
      content_tag(:span, '', class: 'navbar-toggler-icon')
    end
  end

  def navbar_collapse(items)
    content_tag(:div, class: 'collapse navbar-collapse', id: 'navbarNav') do
      content_tag(:ul, class: 'navbar-nav') do
        render_navigation(items)
      end
    end
  end

  def render_navigation(items)
    items.each do |item|
      concat(nav_item(item[:name], item[:path], item[:class]))
    end
  end

  def nav_item(name, path, active_class = '')
    content_tag(:li, class: "nav-item #{active_class}") do
      link_to name, path, class: 'nav-link'
    end
  end
end
