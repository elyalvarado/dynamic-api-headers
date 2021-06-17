Rails.application.routes.draw do
  post '/v1/magic/generate', to: 'magic#create'
  match '/v1/magic/generate', to: 'magic#preflight', via: [:options]
end
