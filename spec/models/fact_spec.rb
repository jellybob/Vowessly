require 'spec_helper'

describe Fact do
  it { should be_mongoid_document }
  it { should be_timestamped_document }
  it { should be_paranoid_document }

  it { should be_embedded_in(:page) }
  
  it { should have_field(:label).of_type(String) }
  it { should have_field(:content_type).of_type(String) }
  it { should have_field(:value).of_type(String) }
  it { should have_field(:source).of_type(String) }
end
