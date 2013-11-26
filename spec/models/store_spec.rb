require 'spec_helper'

describe Store do
  before(:each) do
    @store = Store.new
  end
  it { should validate_presence_of(:store_name) }
  it { should have_many(:products).dependent(:destroy) }
  it { should validate_uniqueness_of(:store_name) }
  it { should have_many(:store_views) }
end
