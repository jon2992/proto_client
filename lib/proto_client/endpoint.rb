module ProtoClient
  class Endpoint
    def initialize(path, verb)
      @path = path
      @verb = verb
    end

    attr_reader :path, :verb
  end
end
