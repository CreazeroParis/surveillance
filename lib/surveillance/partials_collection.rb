module Surveillance
  class PartialsCollection < Array
    def register name, path
      push([name, path])
    end
  end
end
