require 'fileutils'
require 'yaml'
require 'psych'

module Mygem
  # Configuration defaults
  @config = {
      name: 'default'
  }
  @valid_config_keys = @config.keys

  # Configure through hash
  def self.configure(opts = {})
    opts.each { |k, v| @config[k.to_sym] = v if @valid_config_keys.include? k.to_sym }
  end

  # Configure through yaml file
  def self.configure_with(path_to_yaml_file)
    begin
      config = YAML::load(IO.read(path_to_yaml_file))
    rescue Errno::ENOENT
      puts " YAML configuration file couldn 't be found. Using defaults."; return
    rescue Psych::SyntaxError
      puts "YAML configuration file contains invalid syntax. Using defaults."; return
    end

    configure(config)
  end

  def self.get_config_path
    config_path = Dir.home + '/.mygem'
    if Dir.exists?(config_path)
      # use user settings
      config_path
    else
      raise "Can't find config directory. please init by command: 'mygem config'.'"
    end
  end

  # configをyamlから取得
  def self.config
    yml_path = get_config_path + '/settings.yml '
    configure_with(yml_path)
    @config
  end

  # 現在の@configをyamlに保存
  def self.save_config
    yml_path = get_config_path + '/settings.yml '
    if File.exists?(yml_path)
      f = File.open(yml_path, 'w')
      f.print(@config.to_yaml)
      f.close
    else
      raise "Can't find #{yml_path}. please set configure."
    end
  end
end
