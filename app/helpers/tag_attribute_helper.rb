module TagAttributeHelper
  def merge_tag_attrs(default, extra)
    css_class = default.dup.delete(:class)
    extra_css_class = extra.dup.delete(:class)
    css_class = [css_class, "#{extra_css_class}"].compact.join(' ') if extra_css_class

    default.deep_merge(extra).merge(class: css_class)
  end
end
