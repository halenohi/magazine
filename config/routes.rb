Magazine::Engine.routes.draw do
  get ':category_slug', to: 'articles#index', as: :magazine_category_index
  get ':category_slug/:article_slug', to: 'articles#show', as: :magazine_article
end
