require 'rails_helper'

RSpec.describe RecordsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/records').to route_to('records#index')
    end

    it 'routes to #new' do
      expect(get: '/records/new').to route_to('records#new')
    end

    it 'routes to #create' do
      expect(post: '/records').to route_to('records#create')
    end

    it 'routes to #destroy' do
      expect(delete: '/records/1').to route_to('records#destroy', id: '1')
    end
  end
end
