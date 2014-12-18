Magazine::Engine.routes.draw do
  root to: 'articles#index'
  get ':category_slug', to: 'articles#index', as: :category_index
  get ':category_slug/:article_slug', to: 'articles#show', as: :article
end
