require 'spec_helper'

describe LinkQueue do
  subject { LinkQueue.new(3, 3) }
  context :enqueue do
    it 'should add an item to the queue' do
      link = Link.new('/', nil)
      expect { subject.enqueue(link) }.to change { subject.count }.from(0).to(1)
    end

    it 'should not add a link if link depth is exceeds limit' do
      link = double(Link, depth: 4, url: '/')

      expect { subject.enqueue(link) }.not_to change { subject.count }
    end

    it 'should not add a link if link limit exceeds' do
      link = double(Link, depth: 1, url: '/')

      subject.enqueue(link)
      subject.enqueue(link)
      subject.enqueue(link)

      expect { subject.enqueue(link) }.not_to change { subject.count }
    end

    it 'should add an to the queue if the url was added before' do
      subject.enqueue(Link.new('/google', nil))

      expect { subject.enqueue(Link.new('/google', nil)) }.to_not change { subject.count }
    end
  end

  context :dequeue do
    it 'should dequeue' do
      link_1 = double(Link, depth: 1, url: '/')
      link_2 = double(Link, depth: 2, url: '/other')

      subject.enqueue(link_1)
      subject.enqueue(link_2)

      expect { @link = subject.dequeue }.to change { subject.count }.from(2).to(1)
      expect(@link).to eq(link_1)
    end
  end

  context :has_elements? do
    it 'should be false is queue is empty' do
      expect(subject.has_elements?).to eq(false)
    end
    it 'should be true otherwise' do
      subject.enqueue(double(Link, depth: 2, url: '/' ))

      expect(subject.has_elements?).to eq(true)
    end

  end
end