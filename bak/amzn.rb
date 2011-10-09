require 'amazon/ecs'

Amazon::Ecs.configure do |options|
    options[:associate_tag]     = 'mecca09-20'
    options[:AWS_access_key_id] = 'AKIAI7RTRULFWZDRL55A'
    options[:AWS_secret_key]    = '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'
end
res = Amazon::Ecs.item_search('ruby', {:response_group => 'Medium', :sort => 'salesrank'})

res.items.each do |item|
    p item.get('ItemAttributes/Title')
end
