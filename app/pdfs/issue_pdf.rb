class IssuePdf < Prawn::Labels
  def initialize(list, view)
    super(list, { type: "Avery5160" }, &address_layout)
    @view = view
  end

  def address_layout
    layout = Proc.new do |pdf, address|
      pdf.text "#{address.firstname} #{address.lastname}"
      pdf.text address.address1
      pdf.text address.address2 if address.address2.present?
      pdf.text "#{address.city} (#{address.state_id? ? address.state.abbr : address.state_name}) #{address.zipcode}"
      pdf.text "#{address.country}" 
    end
  end
end