# encoding: utf-8
#
# Jekyll generators to add category indexes and audio feeds
#
# Jekyll category page generator.
# http://recursive-design.com/projects/jekyll-plugins/
#
# Version: 0.1.4 (201101061053)
#
# Category generator:
# Copyright (c) 2010 Dave Perrett, http://recursive-design.com/
#
# Audiofeed generator:
#
# Copyright (c) 2012 Sven Pfleiderer, http://blog.roothausen.de/
#
# Licensed under the MIT license (http://www.opensource.org/licenses/mit-license.php)

module Jekyll

  # Jekyll hook - the generate method is called by jekyll, and generates all of the audio format feeds.
  class GenerateAudioFormatFeeds < Generator
    safe true
    priority :low

    def generate(site)
      site.write_audioformat_feeds
    end

  end

  # Jekyll hook - the generate method is called by jekyll, and generates all of the category pages.
  class GenerateCategories < Generator
    safe true
    priority :low

    def generate(site)
      site.write_category_indexes
    end

  end

end

