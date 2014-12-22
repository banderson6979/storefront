OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '317168138486358', 'af25517eb86f9d5d9de3d4bca01079fe'
end
