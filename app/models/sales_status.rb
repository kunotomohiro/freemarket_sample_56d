class SalesStatus < ActiveHash::Base
  self.data = [
    {id: 1, name: '出品中'}, {id: 2, name: '出品停止'}
  ]
end