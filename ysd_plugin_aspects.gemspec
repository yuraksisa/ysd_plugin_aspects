Gem::Specification.new do |s|
  s.name    = "ysd_plugin_aspects"
  s.version = "0.1"
  s.authors = ["Yurak Sisa Dream"]
  s.date    = "2012-05-16"
  s.email   = ["yurak.sisa.dream@gmail.com"]
  s.files   = Dir['lib/**/*.rb','views/**/*.erb','i18n/**/*.yml','static/**/*.*'] 
  s.description = "Entity management integration"
  s.summary = "Entity management integration"
  
  s.add_runtime_dependency "ysd_core_plugins"         # Plugins
  s.add_runtime_dependency "ysd_core_themes"          # Themes
  s.add_runtime_dependency "ysd_md_entitymanagement"  # Entity management model  
    
end
