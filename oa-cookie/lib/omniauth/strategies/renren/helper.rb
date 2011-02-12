module OmniAuth
  module Strategies
    class Renren
      module Helper
        def omniauth_renren_connect_button
          callback_path = "#{OmniAuth.config.path_prefix}/renren/callback"
          @renren_connect_form_id = 'omniauth_renren_connect_form'

          if defined?(::ActionView::Helpers::FormTagHelper)

            form_tag(callback_path, :id => @renren_connect_form_id) do
              renren_connect_button.html_safe
            end
          else

            <<-HTML
<form accept-charset="UTF-8" action="#{callback_path}" id="#{@renren_connect_form_id}" method="post">
#{renren_connect_button}
</form>
            HTML
          end
        end
        
        def omniauth_simple_renren_connect_button(params = {})
          image_path = params[:image_path] ? params[:image_path] : "http://pics.wanlibo.com/images_cn/registration/renren.png"
          simple_renren_connect_button(image_path).html_safe
        end

        private
        
        def simple_renren_connect_button(image_path)
          callback_path = "#{OmniAuth.config.path_prefix}/renren/callback"
          <<-HTML
<img src="#{image_path}" title="renren connect" alt="renren connect" onclick="XN.Connect.requireSession(function(){window.location.href='#{callback_path}';});return false;"></img>        
<script src="http://static.connect.renren.com/js/v1.0/FeatureLoader.jsp" type="text/javascript"></script>
<script type="text/javascript">
  //<![CDATA[
  XN_RequireFeatures(['EXNML'], function(){ XN.Main.init('#{Renren.api_key}', '/xd_receiver.html'); });
  //]]>
</script>
          HTML
        end
        
        def renren_connect_button
          <<-HTML
<xn:login-button autologoutlink="true" onlogin="document.getElementById('#{@renren_connect_form_id}').submit();"></xn:login-button>
<script src="http://static.connect.renren.com/js/v1.0/FeatureLoader.jsp" type="text/javascript"></script>
<script type="text/javascript">
  //<![CDATA[
  XN_RequireFeatures(['EXNML'], function(){ XN.Main.init('#{Renren.api_key}', '/xd_receiver.html'); });
  //]]>
</script>
          HTML
        end
      end
    end
  end
end
