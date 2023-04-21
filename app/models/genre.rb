class Genre < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: 'レディース' },
    { id: 3, name: 'メンズ' },
    { id: 4, name: 'ユニセックス' },
    { id: 5, name: 'キッズ' }
  ]

  include ActiveHash::Associations
  has_many :garments
  end