class AlertsMailer < ActionMailer::Base
  default from: "inspector@assethound.co"

  def alert_requestor(user)
    # @requestor = user
    mail(to: "requestor@example.com", subject: "Alerta en contrato")
  end

  def notify_status_change(inspection_order)
    @inspection_order = inspection_order
    @content = inspection_order.notes.first
    mail to: inspection_order.requester_email,
         subject: "Cambio de estado en la orden de inspección No. #{ inspection_order.id }"
  end

  def notify_asset_inspected(inspection)
    @inspection = inspection
    email_with_name = "#{@inspection.requester_full_name} <#{@inspection.requester_email}>"
    mail to: email_with_name,
      subject: "Orden de Inspección No. #{ inspection.inspection_order_id } ha sido inspeccionada"
  end
end
