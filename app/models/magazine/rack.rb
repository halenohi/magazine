module Magazine
  class Rack
    attr_reader :data

    class << self
      def config_file
        Rails.root.join('config/magazine.yml')
      end
    end

    def initialize
      load_config
    end

    def load_config
      @data = YAML.load(Rack.config_file.read).map{ |datum|
        ::Hashie::Mash.new(datum)
      }
    end

    def find_category(category_slug)
      @data.find{ |datum| datum.category_slug == category_slug }
    end

    def find_article(category_slug, article_slug)
      category = find_category(category_slug)
      return nil if category.nil?
      category.articles.find{ |article| article.slug == article_slug }
    end

    def all_articles_with_category
      data.inject({}) do |result, category|
        category.articles.each do |article|
          result[article] = category.except(:articles)
        end
        result
      end
    end
  end
end
