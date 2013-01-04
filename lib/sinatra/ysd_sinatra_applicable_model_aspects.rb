require 'ui/ysd_ui_entity_management_aspect_render' 
require 'guiblocks/ysd_guiblock_aspects'
require 'ui/ysd_ui_guiblock_entity_aspect_adapter'

module Sinatra
  module YSD
    #
    # Configure the model aspects
    #
    module ApplicableModelAspects
    
      def self.registered(app)
    
        # Add the local folders to the views and translations     
        app.settings.views = Array(app.settings.views).push(File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'views')))
        app.settings.translations = Array(app.settings.translations).push(File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'i18n')))       
        
        # 
        # Show the models to which can be applied aspects
        #
        app.get "/model-aspects/?*" do
          
          context = {:app => self}

          aspects = []
          aspects << UI::GuiBlockEntityAspectAdapter.new(GuiBlock::Aspects.new('/model'), 99, false, true, true, false, 100, true) 
          
          aspects_render=UI::EntityManagementAspectRender.new(context, aspects)           
          locals = aspects_render.render(nil)
          
          load_em_page(:applicable_model_aspect, nil, false, :locals => locals)
          
        end
        
        #
        # Model aspect configuration page (to set up the aspect attributes)
        #
        app.get "/model/:model_name/aspect/:aspect" do
          
          context = {:app => self}
              
          model = (Plugins::ModelAspect.registered_models.select do |m| m.target_model == params['model_name'] end).first 
          aspect = model.aspect(params[:aspect]).get_aspect(context)
          
          if model and aspect

            locals = {}
            locals.store(:aspect, params['aspect'])
            locals.store(:model, params['model_name'])
            locals.store(:model_type, t.model_aspect_configuration.form.entity)
            locals.store(:update_url, "/model/#{params[:model_name]}/aspect/#{params[:aspect]}/config")
            locals.store(:get_url,    "/model/#{params[:model_name]}/aspect/#{params[:aspect]}/config")
            locals.store(:url_base,   "/model/#{params[:model_name]}/aspect/#{params[:aspect]}")
            locals.store(:url_destination, "/model-aspects/#{params['model_name']}")
            locals.store(:description, "#{params[:aspect]} - #{params[:model_name]}")
                    
            if aspect.gui_block.respond_to?(:config)
              locals.store(:aspect_config_form, aspect.gui_block.config(context, model))
            else
              locals.store(:aspect_config_form, '')
            end
      
            if aspect.gui_block.respond_to?(:config_extension)
              locals.store(:aspect_config_form_extension, aspect.gui_block.config_extension(context, model))
            else
              locals.store(:aspect_config_form_extension, '')
            end
          
            load_em_page(:model_aspect_configuration, nil, false, :locals => locals)
          
          else
            status 404
          end

        end
             
      end
    
    end #EntityManagement
  end #YSD
end #Sinatra