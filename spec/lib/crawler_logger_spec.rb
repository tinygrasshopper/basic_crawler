require 'spec_helper'

describe CrawlerLogger do
  it 'should log errors to console' do
    expect(Object).to receive(:puts).with('error')

    CrawlerLogger.error('error')
  end
end