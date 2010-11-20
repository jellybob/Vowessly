require 'spec_helper'

describe Page do
  it { should be_mongoid_document }
  
  it { should have_field(:name).of_type(String) }
  it { should validate_presence_of(:name) }
  
  it { should have_field(:content_type).of_type(String).with_default_value_of("page") }
  it { should validate_presence_of(:content_type) }
end
