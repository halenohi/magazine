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

    def method_missing method, *args, &block
      if method.to_s.end_with?('_path') or method.to_s.end_with?('_url')
        if main_app.respond_to?(method)
          main_app.send(method, *args)
        else
          super
        end
      else
        super
      end
    end

    def magazine_inside_public_period?(article)
      if article.started_at.present? && article.ended_at.present?
        today = Date.today
        article.started_at <= today && article.ended_at >= today
      else
        true
      end
    end

    def respond_to?(method)
      if method.to_s.end_with?('_path') or method.to_s.end_with?('_url')
        if main_app.respond_to?(method)
          true
        else
          super
        end
      else
        super
      end
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
