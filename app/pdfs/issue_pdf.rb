class IssuePdf < Prawn::Document
  def initialize(issue, view)
    super(top_margin: 70)
    @issue = issue
    @view = view
    address
  end
  
  def address
    text "address_goes_here", size: 30, style: :bold
  end  
  
end