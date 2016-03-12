require 'json'
require 'json/api'

describe JSON::API, '#parse' do
  before(:all) do
    @payload = {
      'data' => [
        {
          'type' => 'articles',
          'id' => '1',
          'attributes' => {
            'title' => 'JSON API paints my bikeshed!'
          },
          'links' => {
            'self' => 'http://example.com/articles/1'
          },
          'relationships' => {
            'author' => {
              'links' => {
                'self' => 'http://example.com/articles/1/relationships/author',
                'related' => 'http://example.com/articles/1/author'
              },
              'data' => { 'type' => 'people', 'id' => '9' }
            },
            'comments' => {
              'links' => {
                'self' => 'http://example.com/articles/1/relationships/comments',
                'related' => 'http://example.com/articles/1/comments'
              },
              'data' => [
                { 'type' => 'comments', 'id' => '5' },
                { 'type' => 'comments', 'id' => '12' }
              ]
            }
          }
        }]
    }
  end

  it 'works' do
    document = JSON::API.parse(@payload)

    expect(document.data.first.link_defined?(:self)).to be_truthy
    expect(document.data.first.links.self.value).to eq 'http://example.com/articles/1'
    expect(document.data.first.attributes_keys).to eq ['title']
    expect(document.data.first.attribute_defined?(:title)).to be_truthy
    expect(document.data.first.attributes.title).to eq 'JSON API paints my bikeshed!'
    expect(document.data.first.relationships_keys).to eq %w(author comments)
    expect(document.data.first.relationship_defined?(:author)).to be_truthy
    expect(document.data.first.relationships.author.collection?).to be_falsy
    expect(document.data.first.relationships.author.data.id).to eq '9'
    expect(document.data.first.relationships.author.data.type).to eq 'people'
    expect(document.data.first.relationships.author.link_defined?(:self)).to be_truthy
    expect(document.data.first.relationships.author.links.self.value).to eq 'http://example.com/articles/1/relationships/author'
    expect(document.data.first.relationships.author.link_defined?(:related)).to be_truthy
    expect(document.data.first.relationships.author.links.related.value).to eq 'http://example.com/articles/1/author'
    expect(document.data.first.relationship_defined?(:comments)).to be_truthy
    expect(document.data.first.relationships.comments.collection?).to be_truthy
    expect(document.data.first.relationships.comments.data.size).to eq 2
    expect(document.data.first.relationships.comments.data[0].id).to eq '5'
    expect(document.data.first.relationships.comments.data[0].type).to eq 'comments'
    expect(document.data.first.relationships.comments.data[1].id).to eq '12'
    expect(document.data.first.relationships.comments.data[1].type).to eq 'comments'
    expect(document.data.first.relationships.comments.link_defined?(:self)).to be_truthy
    expect(document.data.first.relationships.comments.links.self.value).to eq 'http://example.com/articles/1/relationships/comments'
    expect(document.data.first.relationships.comments.link_defined?(:related)).to be_truthy
    expect(document.data.first.relationships.comments.links.related.value).to eq 'http://example.com/articles/1/comments'
  end
end
