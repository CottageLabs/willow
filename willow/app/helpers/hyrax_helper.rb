module HyraxHelper
  include ::BlacklightHelper
  include Hyrax::BlacklightOverride
  include Hyrax::HyraxHelperBehavior

  def remove_button(object)
    %Q(<button type="button" class="btn btn-link remove">
         <span class="glyphicon glyphicon-remove"></span>
         <span class="controls-remove-text">#{I18n.t('willow.fields.remove', type: I18n.t('willow.fields.'+object.to_s).downcase.singularize)}</span>
         <span class="sr-only">#{I18n.t("willow.fields.based_near")}
           <span class="controls-field-name-text">#{I18n.t('willow.fields.remove', type: I18n.t('willow.fields.'+object.to_s).downcase.singularize)}</span>
         </span>
       </button>
      ).html_safe
  end

  def add_another_button(object)
    %Q(<button type="button" class="btn btn-link add">
         <span class="glyphicon glyphicon-plus"></span>
         <span class="controls-add-text">#{I18n.t('willow.fields.add_another', type: I18n.t('willow.fields.'+object.to_s).downcase.singularize)}</span>
       </button>
      ).html_safe
  end
end
