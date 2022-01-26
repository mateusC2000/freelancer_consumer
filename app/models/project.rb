class Project
  attr_accessor :title, :description

  def initialize(params)
    @title = params[:title]
    @description = params[:description]
  end

  def self.all
    result = []
    response = Faraday.get('http://freelancer_now:3000/api/v1/projects/')
    return nil if response.status == 500

    if response.status == 200
      data = JSON.parse(response.body, symbolize_names: true)
      data.each do |d|
        result << Project.new(d)
      end
    end
    result
  end

  def self.find(id)
    project = nil
    response = Faraday.get("http://freelancer_now/api/v1/projects/#{id}")
    return nil if response.status == 404

    if response.status == 200
      data = JSON.parse(response.body)
      project = Projects.new({ title: data['title'], description: data['description'] })
    end
    project
  end
end
