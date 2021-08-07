namespace :server_time do
  task :mock => :environment do |t|
    set_time = ENV['RAILS_TIME']
    File.open("tmp/localtime","w") do |file|
      file.puts(set_time)
    end
  end

  task :reset => :environment do
    File.unlink('tmp/localtime')
  end
end