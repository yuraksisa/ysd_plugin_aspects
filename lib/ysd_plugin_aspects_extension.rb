require 'ysd-plugins_viewlistener' unless defined?Plugins::ViewListener

#
# EntityManagement Extension
#
module Huasi

  class AspectsExtension < Plugins::ViewListener

    # ========= Menu =====================
    
    #
    # It defines the admin menu menu items
    #
    # @return [Array]
    #  Menu definition
    #
    def menu(context={})
      
      app = context[:app]
       
      menu_items = [{:path => '/configuration/extensions',
                     :options => {:title => app.t.configuration_admin_menu.extensions.title,
                                  :description => 'Configures the extensions', 
                                  :module => :aspects,
                                  :weight => 3}},
                    {:path => '/configuration/extensions/aspects',
                     :options => {:title => app.t.configuration_admin_menu.extensions.aspects,
                                  :link_route => "/admin/config/aspects",
                                  :description => 'Aspects configuration', 
                                  :module => :aspects,
                                  :weight => 4}}]                      
                     
    end

    # ========= Routes ===================
    
    # routes
    #
    # Define the module routes, that is the url that allow to access the funcionality defined in the module
    #
    #
    def routes(context={})
    
      routes = [{:path => '/admin/aspects',
      	         :regular_expression => /^\/admin\/config\/aspects/, 
                 :title => 'Aspects' , 
                 :description => 'Configure the aspects.',
                 :fit => 1,
                 :module => :aspects},
                {:path => '/admin/aspect/:model_name/:aspect',
                 :parent_path => "/model-aspects",
                 :regular_expression => /^\/admin\/config\/aspect\/.+\/.+/, 
                 :title => 'Model aspect configuration', 
                 :description => 'Edit the model/aspect configuration',
                 :fit => 1,
                 :module => :aspects
                }]
        
    end


              
  end #EntityManagmentExtension
end #Huasi