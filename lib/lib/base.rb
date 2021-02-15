module ClassMattr
  def self.included base
    def base.mattr name=nil
      if name
        ::ClassMattr::Proxy.new(self)._get(name)
      else
        ::ClassMattr::Proxy.new(self)
      end
    end

    def base.method_added name
      ::ClassMattr::Proxy.new(self.class)._set name
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
