module ClassMattr
  class Proxy
    MATTRS   ||= {}
    @@mattrs ||= []

    def initialize host
      @host = host
    end

    def _set name
      while el = @@mattrs.shift
        klass, trait, opts = el
        MATTRS[klass] ||= {}
        el = MATTRS[klass][name.to_sym] ||= {}

        if el[trait]
          # if trait exists, convert to array and push
          el[trait] = [el[trait]] unless el[trait].is_a?(Array)
          el[trait].push opts
        else
          el[trait] = opts || true
        end
      end
    end

    def _get name
      out  = {}

      for klass in @host.ancestors.map(&:to_s)
        return out if klass == 'ClassMattr'

        for key, value in (MATTRS.dig(klass, name.to_sym) || {})
          out[key.to_sym] = value
        end
      end

      raise 'ClassMattr not included?'
    end

    def method_missing name, value=nil
      @@mattrs.push [@host.to_s, name.to_s, value]
    end
  end
end
