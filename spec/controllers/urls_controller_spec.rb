require 'rails_helper'

RSpec.describe UrlsController do
  let!(:created_url) { Url.create(original: Faker::Internet.url) }

  describe 'index' do
    it 'redirects to new form' do
      get :index
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'new' do
    it 'renders shortner form' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'create' do
    it 'creates url item if valid' do
      post :create, params: { url: { original: '' } }
      expect(response).to render_template(:new)
      url = Faker::Internet.url
      post :create, params: { url: { original: url } }
      item = Url.last
      expect(response).to redirect_to(url_path(item.key))
      expect(url).to eq item.original
    end
  end

  describe 'show' do
    it 'renders shortner form' do
      get :show, params: { id: created_url.key }
      expect(response).to render_template(:show)
    end

    it 'renders fallback page if item not found' do
      get :show, params: { id: 'created_url.key' }
      expect(response).to render_template(:not_found)
    end
  end

  describe 'redirect' do
    it 'redirect to original url' do
      get :redirect, params: { key: created_url.key }
      expect(response).to redirect_to(created_url.original)
    end

    it 'increments counter' do
      expect do
        get :redirect, params: { key: created_url.key }
      end.to change { created_url.reload.redirects }.by 1
    end

    it 'renders fallback page if item not found' do
      get :redirect, params: { key: 'created_url.key' }
      expect(response).to render_template(:not_found)
    end
  end
end
