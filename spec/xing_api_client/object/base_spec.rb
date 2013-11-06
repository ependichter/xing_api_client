require 'spec_helper'

describe XingApiClient::Object::Base do
  subject do
    class TestObjectParent < Object
      def other_key; 'stub' end
    end

    class TestObject < TestObjectParent
      include XingApiClient::Object::Base
    end.new({key1: 'value1', key2: 'value2'})
  end

  its(:key1) { should == 'value1' }
  its(:key2) { should == 'value2' }

  it "calls the parent object, if it dosn't find a method" do
    subject.other_key.should == 'stub'
  end
end
