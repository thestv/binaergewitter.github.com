# Title: Assign audio metadata to context variable
# Author: Sven Pfleiderer http://blog.roothausen.de
# Description: Fetch meta information like content length
# and MIME-type via HTTP and assign it to a context variable
#
# Syntax {% assign_audio_metadata var_name = url/to/file %}
#
# Example:
# {% assign_audio_metadata my_metadata = http://site.com/audio.mp3 %}

module Jekyll

  class AssignAudioMetadata < Liquid::Tag

    UrlSyntax = /(#{Liquid::VariableSignature}+)\s*=\s*(((\s*,?)(https?:\/\/)(\S+))+)/
    VarSyntax = /(#{Liquid::VariableSignature}+)\s*=\s*((\.?(\w+))*)/

    def initialize(tag_name, markup, tokens)
      @markup = markup
    end

    def render(context)
      if @markup =~ UrlSyntax
        @var_name = $1
        @file_url = $2
      elsif @markup =~ VarSyntax
        @var_name = $1
        # Look up var content
        @file_url = context[$2]
      end
      
      http_metadata = get_metadata(@file_url)
      context.scopes.last[@var_name] = http_metadata

      ''
    end 

    private

    def get_metadata(file_url)
      if file_url
        url = URI.parse(file_url)
        response = Net::HTTP.start(url.host, url.port) { |http| http.head(url.path) }
        {
          "content_length" => response['content-length'],
          "content_type"   => response['content-type']
        }
      else
        raise "Error processing input, expected an URL, got #{file_url.inspect}"
      end
    end

  end
end

Liquid::Template.register_tag('assign_audio_metadata', Jekyll::AssignAudioMetadata)
