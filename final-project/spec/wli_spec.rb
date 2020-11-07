require './models/wli.rb'

describe Wli do
    context "exercise should calid" do
        
        it "is likes" do
            wli = Wli.new(["Max", "John", "Mark"])
            names = wli.likes
    
            expect(names).to eq("Max, John and Mark like this")
        end
    
        it "is no one" do
            wli = Wli.new(nil)
            names = wli.likes
    
            expect(names).to eq("no one likes this")
        end
    
        it "is anyone" do
            wli = Wli.new(["Peter"])
            names = wli.likes
    
            expect(names).to eq("Peter likes this")
        end
    
        it "is other" do
            name = ["Alex","Jacob","Mark","Max"]
            join_name = [name[0],name[1]].join(', ')
            other = name.length - 2
    
            wli = Wli.new(name)
            names = wli.likes
    
            expect(names).to eq("#{join_name} and #{other} others like this")
        end
    end
end