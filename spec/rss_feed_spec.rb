require 'rubygems'
require 'w3c_validators'

describe 'RSSFeed' do
  it "should be valid XML" do
    ['/../public/feeds/mp3/podcast.xml','/../public/feeds/ogg/podcast.xml'].each do |feed|
      validator = W3CValidators::FeedValidator.new
      file = File.dirname(__FILE__) + feed
      results = validator.validate_file(file)
      results.errors.should == []
    end
  end
end
