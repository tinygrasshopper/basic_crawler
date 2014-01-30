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

end
