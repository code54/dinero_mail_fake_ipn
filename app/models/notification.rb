class Notification
  def initialize(operation_client_ids)
    @operation_client_ids = operation_client_ids
  end

  def document
    builder = Nokogiri::XML::Builder.new do |xml|
      xml.notificacion {
        xml.tiponotificacion 1
        xml.operaciones { @operation_client_ids.each { |id|
          xml.operacion {
            xml.tipo 1
            xml.id id }}}}
    end
    builder.to_xml
  end
end
