require 'rails_helper'

describe Project, type: :model do
  context '.all' do
    it 'should return an array' do
      api_response = File.read(Rails.root.join('spec/support/apis/project_index.json'))
      fake_response = double('faraday_response', status: 200, body: api_response)

      allow(Faraday).to receive(:get).with('http://localhost:3000/api/v1/projects/')
                                     .and_return(fake_response)

      result = Project.all

      expect(result.length).to eq 2
      expect(result[0].title).to eq 'Desenvolvedor de Sites'
      expect(result[0].description).to eq 'Desenvolver projeto de StandUp'
      expect(result[1].title).to eq 'Desenvolvedor de Apps'
      expect(result[1].description).to eq 'Desenvolver App de Lanchonete'
    end

    it 'should return nil if error' do
      fake_response = double('faraday_response', status: 500, body: '')
      allow(Faraday).to receive(:get).with('http://localhost:3000/api/v1/projects/')
                                     .and_return(fake_response)

      result = Project.all

      expect(result).to eq nil
    end
  end
end
