# Title: Simple Content length tag for Jekyll
# Author: Marc Seeger http://blog.marc-seeger.de
# Description: Easily fetch content length for a file
#
# Syntax {% content_length url/to/file %}
#
# Example:
# {% content_length http://site.com/audio.mp3 %}
#
# Output:
# 123453462323

module Jekyll

  class ContentLength < Liquid::Tag
    
    def initialize(tag_name, markup, tokens)
      @markup = markup
      super
    end

    def render(context)
      output = super
      if @markup =~ /((https?:\/\/|\/)(\S+))/i
        @file_url = $1
      elsif @markup =~ /([\w]+(\.[\w]+)*)/i
        # Liquid does not expand variables on custom tags inside templates 
        # so we need to look it up manually
        @file_url = look_up(context, $1)
      end

      generate_html
    end 

    private

    def look_up(context, name)
      lookup = context

      name.split(".").each do |value|
        lookup = lookup[value]
      end

      lookup
    end

    def generate_html
      if @file_url
		url = URI.parse @file_url
		response = Net::HTTP.start(url.host, url.port) { |http| http.head(url.path) }
		response['content-length']
      else
        "Error processing input, expected an URL, got #{@file_url.inspect}"
      end
    end
    
  end
end

Liquid::Template.register_tag('content_length', Jekyll::ContentLength)
