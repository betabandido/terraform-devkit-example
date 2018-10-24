require 'uri'

ROOT_PATH = File.dirname(File.expand_path(__FILE__))

spec = Gem::Specification.find_by_name 'TerraformDevKit'
load "#{spec.gem_dir}/tasks/devkit.rake"

task :custom_test, [:env] do |_, args|
  output = Dir.chdir("envs/#{args.env}") do
    %x[terraform output]
  end

  base_url = URI.extract(output)[0]

  system({'BASE_URL' => base_url}, 'rspec')
end
