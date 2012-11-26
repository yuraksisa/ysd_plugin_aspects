require 'json' unless defined?JSON
require 'uri' unless defined?URI
require 'ysd-plugins' unless defined?Plugins

module Sinatra
  module YSD
  
    #
    # REST API for entity management
    #
    module ApplicableModelAspectsRESTApi
   
      #
      #
      #
      def self.registered(app)
        
        #
        # Retrieve entities
        #
        app.get "/models/?" do
                  
          models = Plugins::ModelAspect.registered_models.map { |rm| {:id => rm.target_model, :aspects => rm.aspects} }

          status 200
          content_type :json
          models.to_json
        
        end
      
        #
        # Retrieve a model
        #
        app.get "/model/:model_name" do
        
          model = (Plugins::ModelAspect.registered_models.select { |m| m.target_model == params['model_name'] }).first
          model = {:id => model.target_model, :aspects => model.aspects}

          status 200
          content_type :json
          model.to_json
        
        end

        #
        # Retrieve entities 
        #
        ["/models/?", "/models/page/:page"].each do |path|
         
          app.post path do

            models = Plugins::ModelAspect.registered_models.map { |rm| {:id => rm.target_model, :aspects => rm.aspects} }
            models_total = models.length
          
            status 200
            content_type :json
            {:data => models, :summary => {:total => models_total}}.to_json
            
          end
        
        end
      
        #
        # Update entity (assign aspects to an entity)
        # 
        app.put "/model" do
        
          request.body.rewind
          
          model_request = JSON.parse(URI.unescape(request.body.read))
          
          if model = (Plugins::ModelAspect.registered_models.select { |m| m.target_model == model_request['id'] }).first
            model.assign_aspects(model_request['aspects'])
          end

          status 200
          content_type :json
          {:id => model.target_model, :aspects => model.aspects}.to_json
        
        end
        
        #
        # Get the entity/aspect configuration attributes
        #
        app.get "/model/:model_name/aspect/:aspect/config" do
                      
          model = (Plugins::ModelAspect.registered_models.select { |m| m.target_model == params['model_name'] }).first
          model_aspect = model.aspect(params['aspect'])
          
          if model and model_aspect
            status 200
            content_type :json
            model_aspect.to_json
          else
            status 404
          end
        
        end
        
        #
        # Update the aspect/entity configuration attributes
        #
        app.put "/model/:model_name/aspect/:aspect/config" do
        
          model = (Plugins::ModelAspect.registered_models.select { |m| m.target_model == params['model_name'] }).first
          model_aspect = model.aspect(params['aspect'])

          if model and model_aspect
            request.body.rewind
            aspect_configuration_request = JSON.parse(URI.unescape(request.body.read)) 
            aspect_configuration_attributes = aspect_configuration_request.delete('aspect_attributes')
            Plugins::ConfiguredModelAspect.transaction do |transaction|
              model_aspect.attributes= aspect_configuration_request
              model_aspect.save
              model_aspect.aspect_attributes=aspect_configuration_attributes
              transaction.commit
            end
            status 200
            content_type :json
            model_aspect.to_json
          else
            status 404
          end 

        end
      
      end
    
    end #EntityManagementRESTApi
  end #YSD
end #Sinatra