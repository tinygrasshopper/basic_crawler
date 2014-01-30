describe Page do
  it 'should fetch a page for the given url' do
    stub_request(:get, 'http://google.com').to_return(body: 'html')

    page = Page.fetch('http://google.com')

    expect(page.content).to eq('html')
  end

  it 'should return the number of input tags on the page' do
    page = Page.new('<input type="text" /><input type="text" /><input type="text" />')


    expect(page.input_count).to eq(3)
  end

  it 'should return the links on the page' do
    page = Page.new('<a href="/home" />')

    expect(page.links).to eq(['/home'])
  end

end