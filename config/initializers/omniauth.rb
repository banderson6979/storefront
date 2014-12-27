OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '317168138486358', 'af25517eb86f9d5d9de3d4bca01079fe'
  provider :twitter, 'XY2UzRuj3vZZtGSkKexZrpzrJ', 'q93iXlnQZZdVE3JM9fMLx4h98jxy76X6z30Tr5r1D9GoW3dhp4'
  provider :instagram, '3e162c82d5014111a37f19e65347ead1', '71f35ca6e4f14554b739b048135a316a'
end
