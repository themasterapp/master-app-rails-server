module ApplicationHelper
  def body_data
    { controller: controller_name, action: action_name }
  end

  def body_class(class_names = nil)
    "#{controller_name} #{action_name} #{class_names}"
  end

  def mobile_variant?
    request.variant.any? { |key| key == :msite || key == :app  }
  end

  def confirm_dialog_data(message, key=nil)
    confirm_key = key || :confirm
    
    { confirm_key => message, cancel_btn: t('cancel_btn'.freeze), confirm_btn: t('confirm_btn'.freeze) }
  end
  
  def confirm_dialog_data_to_delete
    confirm_dialog_data t('confirm_question'.freeze)
  end

  def confirm_dialog_data_to_action_destroy
    confirm_dialog_data(t('confirm_question'.freeze), :confirm_msg).merge!(destroy: :action)
  end
end
