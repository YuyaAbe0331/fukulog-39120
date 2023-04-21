class Height < ActiveHash::Base
  self.data = [
    { id: 1, name: '未選択' },
    { id: 2, name: '100cm以下' },
    { id: 3, name: '101 - 110cm' },
    { id: 4, name: '111 - 120cm' },
    { id: 5, name: '121 - 130cm' },
    { id: 6, name: '131 - 140cm' },
    { id: 7, name: '141 - 150cm' },
    { id: 8, name: '151 - 155cm' },
    { id: 9, name: '156 - 160cm' },
    { id: 10, name: '161 - 165cm' },
    { id: 11, name: '166 - 170cm' },
    { id: 12, name: '171 - 175cm' },
    { id: 13, name: '176 - 180cm' },
    { id: 14, name: '181 - 185cm' },
    { id: 15, name: '186 - 190cm' },
    { id: 16, name: '191cm以上' }
  ]

  include ActiveHash::Associations
  has_many :users
  end