# Title: Simple Audio tag for Jekyll
# Author: Sven Pfleiderer http://blog.roothausen.de
# Description: Easily output HTML5 audio
#
# Syntax {% audio url/to/audio %}
#
# Example:
# {% audio http://site.com/audio.mp3 %}
#
# Output:
# <audio preload='none' controls>
#   <source src='http://site.com/audio.mp3' type='audio/mp3' />
# </audio>

require 'uri'

module Jekyll

  class AudioTag < Liquid::Tag
    
    def initialize(tag_name, markup, tokens)
      @markup = markup
      super
    end

    def render(context)
      output = super

      if @markup =~ /((https?:\/\/|\/)(\S+))/i
        @audio = $1
      elsif @markup =~ /([\w]+(\.[\w]+)*)/i
        # Liquid does not expand variables on custom tags inside templates 
        # so we need to look it up manually
        @audio = look_up(context, $1)
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
      if @audio
        mime_type = get_mime_type(@audio)
        audio =  "<audio preload='none' controls>"
        audio += "<source src='#{@audio}' type='#{mime_type}'/></audio>"
      else
        "Error processing input, expected syntax: {% audio url/to/audio %}"
      end
    end

    def get_mime_type(audio)
      url = URI.parse(audio)
      case url.path
      when /.*\.ogg$/
        "audio/ogg"
      when /.*\.mp3$/
        "audio/mp3"
      when /.*\.m4a$/
        "audio/x-m4a"
      end
    end

  end
end

Liquid::Template.register_tag('audio', Jekyll::AudioTag)
