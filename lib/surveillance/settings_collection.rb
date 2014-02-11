module Surveillance
  class SettingsCollection < HashWithIndifferentAccess
    def method_missing method, *args
      if args.length == 1 && (match = method.to_s.match(/(.*)=$/))
        self[match[1]] = args.first
      elsif key?(method)
        self[method]
      else
        super
      end
    end

    def respond_to?(name, include_private = false)
      (method.to_s =~ /=$/ || key?(method)) ? true : super
    end
  end
end
