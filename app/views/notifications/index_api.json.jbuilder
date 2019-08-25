json.array! @notifications do | notice |
  json.id notice.id
  json.title notice.title
  case notice.action
  when 1
    json.image url_for(notice.sender.avatar)    
  when 2
    json.image url_for(notice.trade.product.images.first)
  when 3
    json.image url_for(notice.product.images.first)
  end
  json.created_at time_ago_in_words(notice.created_at)
  json.checked notice.checked
end