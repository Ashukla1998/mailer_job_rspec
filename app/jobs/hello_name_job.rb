
class HelloNameJob
    include Sidekiq::Worker
  
    def perform(name , times)
      times.times do
        puts "Hello, #{name.upcase}!"
      end
    end
end
  