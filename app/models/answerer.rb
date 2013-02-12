class Answerer
  attr_reader :query

  def initialize(query)
    @query = query
  end

  def answer_document
    builder = Nokogiri::XML::Builder.new do |xml|
      xml.REPORTE {
        xml.ESTADOREPORTE status
          xml.DETALLE {
            xml.OPERACIONES { transactions.each { |transaction|
              xml.OPERACION {
                xml.ID  transaction.client_id
                xml.FECHA transaction.created_at.strftime('%d/%m/%Y %I:%M:%S %p')
                xml.ESTADO transaction.status
                xml.NUMTRANSACCION transaction.id
                xml.COMPRADOR {
                  xml.EMAIL transaction.buyer_email
                  xml.DIRECCION transaction.buyer_address
                  xml.COMENTARIO transaction.buyer_comment
                  xml.NOMBRE transaction.buyer_full_name
                  xml.TELEFONO transaction.buyer_phone
                  xml.TIPODOC transaction.buyer_document_type.upcase
                  xml.NUMERODOC transaction.buyer_document_number }
                xml.MONTO format_amount(transaction.amount)
                xml.MONTONETO format_amount(transaction.net_amount)
                xml.METODOPAGO transaction.payment_method_type
                xml.MEDIOPAGO transaction.payment_method
                xml.CUOTAS transaction.number_of_payments
                xml.ITEMS { transaction.items.each { |item|
                  xml.ITEM {
                    xml.DESCRIPCION item.name
                    xml.MONEDA '1' # TODO
                    xml.PRECIOUNITARIO format_amount(item.amount)
                    xml.CANTIDAD item.quantity }}}
                xml.VENDEDOR
                  # TODO stop faking it.
                  xml.TIPODOC 'DNI'
                  xml.NUMERODOC '12345678' }}}}}
    end
    builder.to_xml
  end

private

  def status
    transactions.empty? ? '8' : '1'
  end

  def transactions
    @transactions ||= Operation.query(query.transaction_ids)
  end

  def format_amount(amount)
    amount.to_s(:rounded, precision: 2, separator: '.')
  end
end
