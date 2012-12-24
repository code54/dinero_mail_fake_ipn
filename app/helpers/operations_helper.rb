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
end
