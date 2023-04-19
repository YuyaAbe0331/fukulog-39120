class Genre < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: 'トップス' },
    { id: 3, name: 'アウター' },
    { id: 4, name: 'ボトムス' },
    { id: 5, name: 'スカート' },
    { id: 6, name: 'その他' }
  ]
  end