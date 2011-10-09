require 'cgi'
require 'base64'
require 'uri'
require 'openssl'
require 'net/http'
uri = URI.parse('http://ecs.amazonaws.jp/onca/xml')
utcnow = Time.now.getutc.strftime('%Y-%m-%dT%H:%M:%SZ')
query = ['Service=AWSECommerceService',
         'AWSAccessKeyId=AKIAI7RTRULFWZDRL55A',
         'Operation=ItemSearch',
         'Keywords=Rocket',
         'SearchIndex=Toys',
         "Timestamp=#{utcnow}",
]
query.map!{|i| a=i.split('=');"#{a[0]}=#{CGI.escape(a[1])}"}.sort!
uri.query=query.join('&')
moji = [ 'GET',
         uri.host,
         uri.path,
         uri.query
       ].join("\n")
hmac =  CGI.escape(Base64.encode64(OpenSSL::HMAC::digest(OpenSSL::Digest::SHA256.new, moji, '7L0R/ioGlz1LDArk1EC+YGoyHrJZzZvwkh2dhSV8')).chomp)
query.push(hmac)
uri.query=query.join('&')
p uri.to_s
Net::HTTP.get_print uri
