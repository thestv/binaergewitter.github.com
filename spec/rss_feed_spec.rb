require 'rubygems'
require 'w3c_validators'

describe 'RSSFeed' do
	it "should be valid XML" do
		@validator = W3CValidators::MarkupValidator.new
		file = File.dirname(__FILE__) + '/../public/podcast.xml'
		results = @validator.validate_file(file)
		results.errors.should == []
	end
end
