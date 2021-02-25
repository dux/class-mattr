module ClassMattr
  def self.included base
    def base.mattr name=nil
      if name
        if name.is_a?(Array)
          for el in name
            self.define_singleton_method(el) do |*args|
              ::ClassMattr::Proxy.new(self).send(el, *args)
            end
          end
        else
          ::ClassMattr::Proxy.new(self)._get(name)
        end
      else
        ::ClassMattr::Proxy.new(self)
      end
    end

    def base.method_added name
      ::ClassMattr::Proxy.new(self)._set name
      super
    end

    def mattr name
      ::ClassMattr::Proxy.new(self.class)._get(name)
    end
  end

  def mattr name
    ::ClassMattr::Proxy.new(self.class)._get(name)
  end
end
