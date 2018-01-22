module HyraxHelper
  include ::BlacklightHelper
  include Hyrax::BlacklightOverride
  include Hyrax::HyraxHelperBehavior

  def remove_button(object)
    %Q(<button type="button" class="btn btn-link remove">
         <span class="glyphicon glyphicon-remove"></span>
         <span class="controls-remove-text">#{I18n.t("willow.fields."+object.to_s)}</span>
         <span class="sr-only"> #{I18n.t("previous")} <span class="controls-field-name-text"> #{I18n.t(object)}</span></span>
    </button>)
  end

  def add_another_button(object)
    %Q(<button type="button" class="btn btn-link add">
         <span class="glyphicon glyphicon-plus"></span>
         <span class="controls-add-text">#{I18n.t(:add_another, object)}</span>
    </button>)
  end
end
