require 'rails_helper'

describe 'Visitor visit home page' do
  context 'API' do
    it 'should view all projects' do
      projects = []
      projects << Project.new({ title: 'Desenvolvedor de Sites' })
      projects << Project.new({ title: 'Desenvolvedor de Apps' })
      allow(Project).to receive(:all).and_return(projects)

      visit root_path

      expect(page).to have_content('Projetos disponíveis via API')
      expect(page).to have_content('Desenvolvedor de Sites')
      expect(page).to have_content('Desenvolvedor de Apps')
    end

    it 'should view error message' do
      allow(Project).to receive(:all).and_return(nil)

      visit root_path

      expect(page).to have_content('Não foi possível consultar os projetos no momento')
    end
  end
end
