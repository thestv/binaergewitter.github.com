# encoding: utf-8
#
# Extensions and monkey patches extending the Jekyll core to add category indexes and feeds
#
# Copyright (c) 2012 Sven Pfleiderer, http://blog.roothausen.de/
#
# Licensed under the MIT license (http://www.opensource.org/licenses/mit-license.php)

$LOAD_PATH << File.dirname(__FILE__)

# Pull in all extensions
require 'jekyll_extensions/page'
require 'jekyll_extensions/site'
require 'jekyll_extensions/post'
require 'jekyll_extensions/generator'
require 'jekyll_extensions/filters'

