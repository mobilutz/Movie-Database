require 'spec_helper'

describe MainController do
  it 'should respond with status 200' do
    get 'index'
    response.status.should eq(200)
  end

  it 'should set the gon variable' do
    get 'index'
    response.request.env['gon'].should be_present
  end

  it 'gon should have the content for movies' do
    get 'index'
    response.request.env['gon']['movies'].should be_present
  end
end
