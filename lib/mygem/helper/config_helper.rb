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
    self.config
    opts.each do |k, v|
      @config[k.to_sym] = v if @valid_config_keys.include? k.to_sym
    end
    self.save_config
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

  # configをyamlから@cofigに取得,
  def self.config
    yml_path = get_config_path + '/settings.yml'
    yml_file = YAML.load_file(yml_path)
    if yml_file
      @config = yml_file
    else
      File.open(yml_path, 'w') { |f| YAML.dump(@config, f) }
    end
  end

  # 現在の@configをyamlに保存
  def self.save_config
    yml_path = get_config_path + '/settings.yml'
    if File.exists?(yml_path)
      File.open(yml_path, 'w') { |f| YAML.dump(@config, f) }
    else
      raise "Can't find #{yml_path}. please set configure."
    end
  end
end
