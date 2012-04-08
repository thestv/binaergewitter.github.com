# encoding: utf-8

module Jekyll

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
      self.read_yaml(File.join(base, '_includes/custom'), 'audioformat_feed.xml')
      self.data['audioformat']    = audioformat
      # Set the title for this page.
      title_prefix             = site.config['audioformat_title_prefix'] || 'Audio format: '
      self.data['title']       = "#{title_prefix}#{audioformat}"
      # Set the meta-description for this page.
      meta_description_prefix  = site.config['audioformat_meta_description_prefix'] || 'Audio format: '
      self.data['description'] = "#{meta_description_prefix}#{audioformat}"

      # Set the correct feed URL.
      self.data['feed_url'] = "#{audioformat_feed_dir}/#{name}"
    end

    # Returns the object as a debug String.
    def inspect
      "#<Jekyll:CategoryFeed @name=#{@name.inspect}> @base=#{@base.inspect} @dir=#{@dir.inspect} @data=#{self.data.inspect} @site=#{@site}"
    end

  end

  # The Site class is a built-in Jekyll class with access to global site config information.
  class Site

    attr_accessor :audioformats

    # Reset Site details.
    #
    # Overrides jekyll's reset method to add audio formats
    #
    # Returns nothing
    def reset
      puts "Calling Site.reset"
      self.time            = if self.config['time']
                               Time.parse(self.config['time'].to_s)
                             else
                               Time.now
                             end
      self.layouts         = {}
      self.posts           = []
      self.pages           = []
      self.static_files    = []
      self.categories      = Hash.new { |hash, key| hash[key] = [] }
      self.audioformats    = Hash.new { |hash, key| hash[key] = [] }
      self.tags            = Hash.new { |hash, key| hash[key] = [] }

      if !self.limit_posts.nil? && self.limit_posts < 1
        raise ArgumentError, "Limit posts must be nil or >= 1"
      end
    end


    # Read all the files in <source>/<dir>/_posts and create a new Post
    # object with each one.
    #
    # Overrides jekyll's read_post method to add audio formats
    #
    # dir - The String relative path of the directory to read.
    #
    # Returns nothing.
    def read_posts(dir)
      base = File.join(self.source, dir, '_posts')
      return unless File.exists?(base)
      entries = Dir.chdir(base) { self.filter_entries(Dir['**/*']) }

      # first pass processes, but does not yet render post content
      entries.each do |entry|
        if Post.valid?(entry)
          post = Post.new(self, self.source, dir, entry)
          puts post.audioformats.inspect

          if post.published && (self.future || post.date <= self.time)
            self.posts << post
            post.categories.each { |c| self.categories[c] << post }
            post.audioformats.each { |f| self.audioformats[f] << post }
            post.tags.each { |c| self.tags[c] << post }
          end
        end
      end

      self.posts.sort!

      # limit the posts if :limit_posts option is set
      if limit_posts
        limit = self.posts.length < limit_posts ? self.posts.length : limit_posts
        self.posts = self.posts[-limit, limit]
      end
    end

    # Creates an instance of AudioFormatFeed for each audio format, renders it, and
    # writes the output to a file.
    #
    #  +audioformat_feed_dir+ is the String path to the audioformat folder.
    #  +audioformat+     is the audioformat currently being processed.
    def write_audioformat_feed(audioformat_feed_dir, audioformat)

      # Create an Atom-feed for each audio format.
      feed = AudioFormatFeed.new(self, self.source, audioformat_feed_dir, audioformat)
      feed.render(self.layouts, site_payload)
      feed.write(self.dest)
      # Record the fact that this feed has been added, otherwise Site::cleanup will remove it.
      self.pages << feed
    end

    # Loops through the list of audio formats and processes each one.
    def write_audioformat_feeds
      dir = self.config['audioformat_feed_dir'] || 'audioformat_feeds'

      puts "@audioformats: #{self.audioformats}"

      self.audioformats.keys.each do |audioformat|
        puts "Processing #{audioformat}"
        self.write_audioformat_feed(File.join(dir, audioformat.gsub(/_|\P{Word}/, '-').gsub(/-{2,}/, '-').downcase), audioformat)
      end
    end

  end

  # The Post class is a built-in Jekyll class
  class Post

    def audioformats
      formats = self.data["audioformats"] || {}
      formats.keys
    end

  end

  # Jekyll hook - the generate method is called by jekyll, and generates all of the category pages.
  class GenerateAudioFormatFeeds < Generator
    safe true
    priority :low

    def generate(site)
      site.write_audioformat_feeds
    end

  end

end

