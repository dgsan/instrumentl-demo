class TaxParser < Nokogiri::XML::SAX::Document
  def start_element(name, attrs = [])
    puts name.inspect
    puts attrs.inspect
    # Handle each element, expecting the name and any attributes
  end

  def characters(string)
    puts string.inspect
    # Any characters between the start and end element expected as a string
  end

  def end_element(name)
    puts name.inspect
    # Given the name of an element once its closing tag is reached
  end
end
