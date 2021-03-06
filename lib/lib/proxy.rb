module ClassMattr
  class Proxy
    MATTRS   ||= {}
    @@mattrs ||= []

    def initialize host
      @host = host
    end

    def _set name
      while el = @@mattrs.shift
        klass, trait, opts = el[0], el[1].to_sym, el[2]

        MATTRS[klass] ||= {}
        el = MATTRS[klass][name.to_sym] ||= {}

        # default value if true if no argument provided
        el[trait] = opts.nil? ? true : opts
      end
    end

    def _get name
      for klass in @host.ancestors.map(&:to_s)
        return {} if klass == 'ClassMattr'

        hash = MATTRS.dig(klass, name.to_sym)
        return hash if hash
      end

      raise 'ClassMattr not included?'
    end

    def get_hash
      name = :__mattr_tmp
      _set name
      MATTRS[@host.to_s].delete(name)
    end

    def method_missing name, value=nil
      @@mattrs.push [@host.to_s, name.to_s, value]
    end
  end
end
