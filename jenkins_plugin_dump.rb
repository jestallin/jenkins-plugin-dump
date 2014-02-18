#!/usr/bin/env ruby

require 'trollop'
require 'jenkins_api_client'
include JenkinsApi

# CLI options
opts = Trollop::options do
    opt :server_url, "Jenkins server url ", :type => :string
    opt :username, "Jenkins username", :type => :string       
    opt :password, "Jenkins password", :type => :string  
end

# Exit if the server url is empty
Trollop::die :server_url, "cannot be empty" if opts[:server_url].nil?

@client = Client.new(:server_url => opts.server_url,
         :username => opts.username, :password => opts.password)

# Print version
p "Jenkins Version"
p @client.get_jenkins_version

# Example output 
# 'git' -> { version => '1.1.1' }
p "Jenkins Plugins"
@client.plugin.list_installed.each{| key, value | puts %Q(\'#{key}\' => { version => \'#{value}\' },) }