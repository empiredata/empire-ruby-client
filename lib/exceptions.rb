
class Empire
  class APIError < RuntimeError; end

  class MissingSecretsError < RuntimeError
    def initialize(msg = "Secrets must be provided when connecting to a service, or a secrets YAML file must be given when constructing this instance")
      super
    end
  end

  class MissingEnduserError < RuntimeError
    def initialize(msg = "Cannot use a materialized view within a session initiated without an enduser")
      super
    end
  end

  class MissingServiceError < RuntimeError
    def initialize(msg = "Service must be specified")
      super
    end
  end
end