class Wli
    attr_reader :name

    def initialize(name)
        @name = name
    end

    def likes
        
        return "no one likes this" if name.nil? || name.empty?
        
        return "#{name[0]} likes this" if name.length.eql?(1)
        
       
        if name.length > 3
            join_name = [name[0],name[1]].join(', ')
            other = name.length - 2
            return "#{join_name} and #{other} others like this" 
        end

        if name.length.eql?(3)
            format_name = [name[0],name[1]].join(', ')
            return "#{format_name} and #{name[-1]} like this"
        end
    end
end