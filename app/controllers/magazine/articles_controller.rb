module Magazine
  class ArticlesController < ::ApplicationController
    helper Magazine::ApplicationHelper
    before_action :set_magazine_rack
    helper_method :article_in_review?

    # GET /mount_point(/:category_slug)
    def index
      find_category(params[:category_slug])
    end

    # GET /mount_point/:category_slug/:article_slug
    def show
      find_article(params[:category_slug], params[:article_slug])
    end

    private
      def find_category(category_slug = '')
        category_slug = params[:category_slug] if category_slug.blank?

        @category = @magazine_rack.find_category(category_slug)

        not_found if @category.nil? && category_slug.present?
      end

      def find_article(category_slug = '', article_slug = '')
        category_slug = params[:category_slug] if category_slug.blank?
        article_slug = params[:article_slug] if article_slug.blank?

        @category = @magazine_rack.find_category(category_slug)
        @article = @magazine_rack.find_article(category_slug, article_slug)

        not_found if @article.nil? || article_in_review?(@article)
      end

      def set_magazine_rack
        @magazine_rack = Magazine::Rack.new
      end

      def article_in_review?(article)
        !(!article.review || (article.review && authorize))
      end

      def not_found
        raise ActionController::RoutingError.new('Not found magazine article')
      end

      def authorize
        if Magazine.authorize_method_name.present?
          send(Magazine.authorize_method_name)
        else
          true
        end
      end
  end
end
