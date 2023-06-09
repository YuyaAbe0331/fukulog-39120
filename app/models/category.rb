class Category < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: 'Tシャツ' },
    { id: 3, name: 'シャツ' },
    { id: 4, name: 'パーカー' },
    { id: 5, name: 'スウェット' },
    { id: 6, name: 'ニット' },
    { id: 7, name: 'セーター' },
    { id: 8, name: 'ベスト' },
    { id: 9, name: 'コート' },
    { id: 10, name: 'ジャケット' },
    { id: 11, name: 'ブルゾン' },
    { id: 12, name: 'スカート' },
    { id: 13, name: 'ミニスカート' },
    { id: 14, name: 'ロングスカート' },
    { id: 15, name: 'ワンピース' },
    { id: 16, name: 'デニム' },
    { id: 17, name: 'スラックス' },
    { id: 18, name: 'チノパン' },
    { id: 19, name: 'ハーフパンツ' },
    { id: 20, name: 'ショートパンツ' },
    { id: 21, name: 'ワイドパンツ' },
    { id: 22, name: 'スキニーパンツ' },
    { id: 23, name: 'カーゴバンツ' },
    { id: 24, name: 'ジョガーパンツ' },
    { id: 25, name: 'アンクルパンツ' },
    { id: 26, name: 'その他' }
  ]
  include ActiveHash::Associations
  has_many :garments
  
  end