#!/usr/bin/env ruby
#
# Sensu Handler: pushover
#
# This handler formats alerts and sends them off to a the pushover.net service.
#
# Copyright 2012 David Wooldridge (https://github.com/z0mbix | http://twitter.com/z0mbix)
#
# Released under the same terms as Sensu (the MIT license); see LICENSE
# for details.

require 'net/https'
require 'sensu-handler'
require 'timeout'

#
#
#
class Pushover < Sensu::Handler
  def event_name
    @event['client']['name'] + '/' + @event['check']['name']
  end

  def handle
    apiurl = settings['pushover']['apiurl'] || 'https://api.pushover.net/1/messages'

    keys = if settings['pushover']['keys']
             settings['pushover']['keys']
           else
             [
               {
                 'userkey' => settings['pushover']['userkey'],
                 'token' => settings['pushover']['token']
               }
             ]
           end

    priority = if @event['check']['status'] < 3
                 @event['check']['status'] - 1
               else
                 0
               end

    params = {
      title: event_name,
      token: settings['pushover']['token'],
      priority: priority,
      message: @event['check']['output']
    }

    url = URI.parse(apiurl)
    req = Net::HTTP::Post.new(url.path)
    res = Net::HTTP.new(url.host, url.port)
    res.use_ssl = true
    res.verify_mode = OpenSSL::SSL::VERIFY_PEER

    keys.each do |key|
      begin
        Timeout.timeout(5) do
          params['user'] = key['userkey']
          params['token'] = key['token']
          req.set_form_data(params)
          res.start { |http| http.request(req) }
          puts 'pushover -- sent alert for ' + event_name + ' to user: ' + params['user'] + ', token: ' + params['token'] + '.'
        end
      rescue Timeout::Error
        puts 'pushover -- timed out while attempting to ' + @event['action'] + ' a incident -- ' + event_name
      end
    end
  end
end
