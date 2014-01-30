require 'spec_helper'

describe InputCounter do
  it 'should save link count' do
    counter = InputCounter.new

    link = Link.new('/', nil)

    counter.increment(link, 2)

    expect(counter.links).to eq(link => 2)
  end

  it 'should increment the link count' do
    counter = InputCounter.new

    link = Link.new('/', nil)

    counter.increment(link, 2)
    counter.increment(link, 2)

    expect(counter.links).to eq(link => 4)
  end


  it 'should increment the link count for parent if exist' do
    counter = InputCounter.new

    parent_link = Link.new('/', nil)
    link = Link.new('/', parent_link)

    counter.increment(link, 2)

    expect(counter.links).to eq(parent_link => 2, link => 2)
  end

end