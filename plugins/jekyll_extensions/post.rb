# encoding: utf-8
#
# Monkeypatches extending Jekyll:Post to make audioformats accessible
#
# Copyright (c) 2012 Sven Pfleiderer, http://blog.roothausen.de/
#
# Licensed under the MIT license (http://www.opensource.org/licenses/mit-license.php)

module Jekyll

  # The Post class is a built-in Jekyll class
  class Post

    def audioformats
      formats = self.data["audioformats"] || {}
      formats.keys
    end

  end

end

