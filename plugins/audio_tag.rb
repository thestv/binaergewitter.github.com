# Title: Simple Audio tag for Jekyll
# Author: Sven Pfleiderer http://blog.roothausen.de
# Description: Easily output HTML5 audio
#
# Syntax {% video url/to/video [width height] [url/to/poster] %}
#
# Example:
# {% audio http://site.com/audio.mp3 %}
#
# Output:
# <audio preload='none' controls>
#   <source src='http://site.com/audio.mp3' type='audio/mp3' />
# </video>

require 'URI'

module Jekyll

  class AudioTag < Liquid::Tag
    @video = nil

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
      if url.path =~ /.*\.ogg$/
        "audio/ogg"
      elsif url.path =~ /.*\.mp3$/
        "audio/mp3"
      end
    end

  end
end

Liquid::Template.register_tag('audio', Jekyll::AudioTag)
