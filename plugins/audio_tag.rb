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
      if markup =~ /((https?:\/\/|\/)(\S+))/i
        @audio = $1
        @mime_type = get_mime_type(@audio)
      end
      super
    end

    def render(context)
      output = super
      if @audio
        audio =  "<audio preload='none' controls>"
        audio += "<source src='#{@audio}' type='#{@mime_type}'/></audio>"
      else
        "Error processing input, expected syntax: {% audio url/to/audio %}"
      end
    end 

    private

    def get_mime_type(audio)
      url = URI.parse(audio)
      if url.path =~ /.*\.ogg$/
        "audio/ogg"
      else
        "audio/mp3"
      end
    end

  end
end

Liquid::Template.register_tag('audio', Jekyll::AudioTag)
