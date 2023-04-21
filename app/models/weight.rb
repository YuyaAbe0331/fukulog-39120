class Weight < ActiveHash::Base
  self.data = [
    { id: 1, name: '未選択' },
    { id: 2, name: '30kg以下' },
    { id: 3, name: '31 - 35kg' },
    { id: 4, name: '36 - 40kg' },
    { id: 5, name: '41 - 45kg' },
    { id: 6, name: '46 - 50kg' },
    { id: 7, name: '51 - 55kg' },
    { id: 8, name: '56 - 60kg' },
    { id: 9, name: '61 - 65kg' },
    { id: 10, name: '66 - 70kg' },
    { id: 11, name: '71 - 75kg' },
    { id: 12, name: '76 - 80kg' },
    { id: 13, name: '81 - 85kg' },
    { id: 14, name: '86 - 90kg' },
    { id: 15, name: '91kg以上' }
  ]

  include ActiveHash::Associations
  has_many :users
  end