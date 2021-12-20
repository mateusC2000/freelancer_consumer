class Project
  attr_accessor :title, :description

  def initialize(hash_parameters)
    @title = hash_parameters[:title]
    @description = hash_parameters[:description]
  end


  def self.all
    projects = []
    response = Faraday.get("http://localhost:3000/api/v1/projects/")

    if response.status == 200
      data = JSON.parse(response.body)
      data.each do |d|
        projects << Project.new({ title: d["title"], description: d["description"] })
      end
    end

    return projects
  end


  def self.find(id)
    project = nil
    response = Faraday.get("http://localhost:3000/api/v1/projects/#{id}")
    return nil if response.status == 404
    if response.status == 200
      data = JSON.parse(response.body)
      project = Project.new({ title: data["title"], description: data["description"] })
    end
    return project
  end
end 