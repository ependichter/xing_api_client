require 'spec_helper'

describe XingApiClient::Request do
  subject { XingApiClient::Request }
  let(:instance){ subject.new(consumer_token_object) }
  let(:consumer_token_object) { double('consumer_token_object') }

  describe '.new' do
    it 'sets the intsance variable access_token to the argument when it gets initialized' do
      instance.instance_variable_get('@consumer_token').should == consumer_token_object
    end
  end

  describe '#generate_url_params!' do
    it 'returns a string with url-encoded values' do
      instance.send(:generate_url_params, user_id: '1_abcdef', message: 'abcABC#./_').should == "?user_id=1_abcdef&message=abcABC%23.%2F_"
    end
  end

  describe '#add_default_values' do
    it 'returns a hash' do
      instance.send(:add_default_values, nil).should == {}
      instance.send(:add_default_values, {}).should == {}
    end

    it 'returns a hash with all keys' do
      instance.send(:add_default_values, {a: '', b: '', c: ''}).keys.should == [:a, :b, :c]
    end

    context 'offset' do
      it 'returns an integer' do
        instance.send(:add_default_values, offset: nil).should == { offset: 0 }
        instance.send(:add_default_values, offset: '5').should == { offset: 5 }
        instance.send(:add_default_values, offset: 5).should   == { offset: 5 }
      end
    end

    context 'user_fields' do
      it 'returns a string' do
        instance.send(:add_default_values, user_fields: nil).should == { user_fields: XingApiClient::Object::User::AVAILABLE_FIELDS.join(',') }
        instance.send(:add_default_values, user_fields: 'id,name').should == { user_fields: 'id,name' }
      end
    end

    context 'other values' do
      it 'returns the values untouched' do
        test_thing = stub('something')
        instance.send(:add_default_values, other: test_thing ).should == { other: test_thing }
      end
    end
  end

  describe '#handle_error!' do
    context 'If the error is defined, it...' do
      XingApiClient::Request::ERROR_CLASSES.each_pair do |api_error_code, error_class|
        it "raises an #{error_class}" do
          expect { instance.send(:handle_error!,'1234', 'error_name' => api_error_code) }.
            to raise_error( error_class )
        end
      end
    end

    context 'If the error is undefined, it...' do
      it "raises an XingApiClient::Request::Error" do
        expect { instance.send(:handle_error!,'1234', 'error_name' => 'RSPEC_TEST_EXCEPTION') }.
          to raise_error( XingApiClient::Request::Error )
      end
    end
  end
end
