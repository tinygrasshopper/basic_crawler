require 'spec_helper'

describe Logger do
  it 'should log errors to console' do
    expect(Object).to receive(:puts).with('error')

    Logger.error('error')
  end
end