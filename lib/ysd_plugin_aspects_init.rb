require 'ysd-plugins' unless defined?Plugins::Plugin

Plugins::SinatraAppPlugin.register :aspects do

   name=        'aspects'
   author=      'yurak sisa'
   description= 'Manage aspects'
   version=     '0.1'
   hooker            Huasi::AspectsExtension   
   sinatra_extension Sinatra::YSD::ApplicableModelAspects        # Applicable model aspects application
   sinatra_extension Sinatra::YSD::ApplicableModelAspectsRESTApi # Applicable model aspects Rest API     
end