require 'spec_helper'

describe Link do
  context :equality do
    it 'should be equal to another queue with the same url and parent' do
      link = Link.new('/', Link.new('/about', nil))

      expect(link).to eq(Link.new('/', Link.new('/about', nil)))
      expect(link).not_to eq(Link.new('/other', Link.new('/about', nil)))
      expect(link).not_to eq(Link.new('/other', nil))
      expect(link).not_to eq('a string')
    end
  end

  context :depth do
    it 'have depth 1 if no parent' do
      expect(Link.new('/', nil).depth).to eq(1)
    end

    it 'have depth parent depth +1 if it has a parent' do
      expect(Link.new('/', double(depth: 1)).depth).to eq(2)
    end
  end

end
