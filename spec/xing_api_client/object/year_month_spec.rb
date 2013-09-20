require 'spec_helper'

describe XingApiClient::Object::YearMonth do
  subject { XingApiClient::Object::YearMonth.new(year_month_string) }

  describe 'the year month string is nil' do
    let(:year_month_string) { nil }

    its(:year) { should be_nil }
    its(:month) { should be_nil }

    its(:to_date) { should == Date.new }

    it '<=> Date.parse("2000-12-20")' do
      (subject <=> Date.parse("2000-12-20")).should == -1
    end

    it '<=> .new("2000-12-20")' do
      (subject <=> subject.class.new("2000-12-20")).should == -1
    end
  end

  describe 'the year month string is empty' do
    let(:year_month_string) { '' }

    its(:year) { should be_nil }
    its(:month) { should be_nil }
    its(:to_date) { should == Date.new }

    it '<=> Date.parse("2000-12-20")' do
      (subject <=> Date.parse("2000-12-20")).should == -1
    end

    it '<=> .new("2000-12")' do
      (subject <=> subject.class.new("2000-12")).should == -1
    end
  end

  describe 'the year date string contains only a year' do
    let(:year_month_string) { '2010' }

    its(:year) { should == 2010 }
    its(:month) { should be_nil }
    its(:to_date) { should == Date.parse("2010-1-1") }

    it '<=> Date.parse("2000-12-20")' do
      (subject <=> Date.parse("2000-12-20")).should == 1
    end

    it '<=> .new("2000-12")' do
      (subject <=> subject.class.new("2000-12")).should == 1
    end
  end

  describe 'the year date string contains a year and a month' do
    let(:year_month_string) { '2000-5' }

    its(:year) { should == 2000 }
    its(:month) { should == 5 }
    its(:to_date) { should == Date.parse("2000-5-1") }

    it '<=> Date.parse("2000-5-1")' do
      (subject <=> Date.parse("2000-5-1")).should == 0
    end

    it '<=> .new("2000-5")' do
      (subject <=> subject.class.new("2000-5")).should == 0
    end
  end
end
