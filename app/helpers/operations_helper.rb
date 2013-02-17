# encoding: utf-8
module OperationsHelper
  def buyer_document_types_collection
    [['D.N.I.', 'dni']]
  end

  def payment_method_types_collection
    [['Tarjeta de Crédito', 3]]
  end

  def payment_methods_collection
    [['Visa', 'VISA']]
  end

  def number_of_payments_collection
    [0]
  end

  def statuses_collection
    [['Pendiente De Pago', 1], ['Acreditado', 2], ['Cancelado', 3]]
  end

  def schedule_delays_collection
    [['No Esperar', 0], ['1 Minuto', 1], ['5 Minutos', 5], ['15 Minutos', 15]]
  end

  def notification_delays_collection
    [['No Notificar', -1], ['No Esperar', 0], ['1 Minuto', 1], ['5 Minutos', 5], ['15 Minutos', 15]]
  end
end
