# encoding: utf-8
#
# Classes inherting from Jekyll::Page
#
# Available _config.yml settings :
#
# Category generator:
# - category_title_prefix:    The string used before the category name in the page title
# - category_meta_description_prefix
#
# Audiofeed generator:
# - audioformat_title_prefix: The string used before the audio format name
# - audioformat_meta_description_prefix


module Jekyll

  # The CategoryFeed class creates an Atom feed for the specified audio format.
  class AudioFormatFeed < Page

    # Initializes a new AudioFormatFeed.
    #
    #  +base+            is the String path to the <source>.
    #  +audioformat_feed_dir+ is the String path between <source> and the audio format folder.
    #  +audioformat+     is the audio format currently being processed.
    def initialize(site, base, audioformat_feed_dir, audioformat)
      @site = site
      @base = base
      @dir  = audioformat_feed_dir
      @name = 'podcast.xml'
      self.process(@name)
      # Read the YAML data from the layout page.
      self.read_yaml(File.join(base, '_includes/feed'), 'audioformat_feed.xml')
      self.data['audioformat']    = audioformat
      title_prefix             = site.config['audioformat_title_prefix'] || 'Audio format: '
      self.data['title']       = "#{title_prefix}#{audioformat}"
      meta_description_prefix  = site.config['audioformat_meta_description_prefix'] || 'Audio format: '
      self.data['description'] = "#{meta_description_prefix}#{audioformat}"
      self.data['feed_url'] = "#{audioformat_feed_dir}/#{name}"
    end

    # Returns the object as a debug String.
    def inspect
      "#<Jekyll:CategoryFeed @name=#{@name.inspect}> @base=#{@base.inspect} @dir=#{@dir.inspect} @data=#{self.data.inspect} @site=#{@site}"
    end

  end

  # The CategoryIndex class creates a single category page for the specified category.
  class CategoryIndex < Page

    # Initializes a new CategoryIndex.
    #
    #  +base+         is the String path to the <source>.
    #  +category_dir+ is the String path between <source> and the category folder.
    #  +category+     is the category currently being processed.
    def initialize(site, base, category_dir, category)
      @site = site
      @base = base
      @dir  = category_dir
      @name = 'index.html'
      self.process(@name)
      # Read the YAML data from the layout page.
      self.read_yaml(File.join(base, '_layouts'), 'category_index.html')
      self.data['category']    = category
      # Set the title for this page.
      title_prefix             = site.config['category_title_prefix'] || 'Category: '
      self.data['title']       = "#{title_prefix}#{category}"
      # Set the meta-description for this page.
      meta_description_prefix  = site.config['category_meta_description_prefix'] || 'Category: '
      self.data['description'] = "#{meta_description_prefix}#{category}"
    end

  end

  # The CategoryFeed class creates an Atom feed for the specified category.
  class CategoryFeed < Page

    # Initializes a new CategoryFeed.
    #
    #  +base+         is the String path to the <source>.
    #  +category_dir+ is the String path between <source> and the category folder.
    #  +category+     is the category currently being processed.
    def initialize(site, base, category_dir, category)
      @site = site
      @base = base
      @dir  = category_dir
      @name = 'atom.xml'
      self.process(@name)
      # Read the YAML data from the layout page.
      self.read_yaml(File.join(base, '_includes/feed'), 'category_feed.xml')
      self.data['category']    = category
      # Set the title for this page.
      title_prefix             = site.config['category_title_prefix'] || 'Category: '
      self.data['title']       = "#{title_prefix}#{category}"
      # Set the meta-description for this page.
      meta_description_prefix  = site.config['category_meta_description_prefix'] || 'Category: '
      self.data['description'] = "#{meta_description_prefix}#{category}"

      # Set the correct feed URL.
      self.data['feed_url'] = "#{category_dir}/#{name}"
    end

  end

end

