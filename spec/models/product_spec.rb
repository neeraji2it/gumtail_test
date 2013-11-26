require 'spec_helper'

describe Product do
  before(:each) do
    @product=product
  end
  def product
    Product.new
  end
  
  context "associations" do
    it "should have many tags" do
      should have_many(:tags).through(:taggings)
    end
    it "should have many recommendations" do
      should have_many(:recommendations).dependent(:destroy)
    end
    it "should have many transactions" do
      should have_many(:transactions).dependent(:destroy)
    end
    it "should have many fields" do
      should have_many(:fields)
    end
    it "should have many offers" do
      should have_many(:offers)
    end
    it "should have many variants" do
      should have_many(:variants)
    end
    it "should have many sprofiles" do
      should have_many(:sprofiles).dependent(:destroy)
    end
    it "should have many product_views" do
      should have_many(:product_views)
    end
    it "should have many requests" do
      should have_many(:requests).dependent(:destroy)
    end
  end
  
  context "validations" do
    it "should require product title" do
      @product.product_title=''
      @product.should_not be_valid
    end
    
    it "should require description" do
      @product.description=''
      @product.should_not be_valid
    end
  end
  
  context "callbacks" do
    it "should call before create" do
      should callback(:generate_random_no).before(:create)
      should callback(:update_iq_field).before(:create)
    end
  end
  
  it "should accept nested attributes for sprofiles" do
    should accept_nested_attributes_for(:sprofiles)
  end

  it "should accept nested attributes for variants" do
    should accept_nested_attributes_for(:variants)
  end

  it "should accept nested attributes for offers" do
    should accept_nested_attributes_for(:offers)
  end
  
  it "should accept nested attributes for fields" do
    should accept_nested_attributes_for(:fields)
  end
  
  it "should accept nested attributes for names" do
    should accept_nested_attributes_for(:names)
  end
end
