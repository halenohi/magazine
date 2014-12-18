module Magazine
  module ApplicationHelper
    def magazine_image_tag(path, options = {})
      image_tag(magazine_image_path(path, options), options.except(:category, 'category'))
    end

    def magazine_image_path(path, options = {})
      category = _magazine_val(:category, options)
      article = _magazine_val(:article, options)

      image_path(['magazine', category.try(:category_slug), article.try(:slug), path].compact.join('/'))
    end

    def magazine_partial_path(name = nil, options = {})
      category = _magazine_val(:category, options)
      article = _magazine_val(:article, options)

      ['magazine', 'articles', 'shared', category.try(:category_slug), article.try(:slug), name].compact.join('/')
    end

    private
      def _magazine_val(name, options)
        val = nil
        val = instance_variable_get("@#{ name }") if instance_variable_get("@#{ name }").present?
        val = options[name.to_sym] if options[name.to_sym].present?
        val = options[name.to_s] if options[name.to_s].present?
        val
      end
  end
end
