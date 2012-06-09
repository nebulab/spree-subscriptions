class IssuePdf < Prawn::Document
  def initialize(issue, view)
    super(left_margin: 16, right_margin: 16, page_size: 'A4')
    @issue = issue
    @view = view
    address
  end
  
  def address
    print_page_labels 
    start_new_page
    print_page_labels
  end  

  def print_page_labels
    define_grid(columns: 3, rows: 10, column_gutter: 12, row_gutter: 10)
    grid.rows.times do |row|
      grid.columns.times do |column|
        cell = grid(row, column)
        self.bounding_box(cell.top_left, width: cell.width, height: cell.height) do 
          indent 7 do
            move_down 7                 
            text "Name"
            text "Address"
            text "Address 2"
            text "City CAP State"
          end
          stroke do
            rectangle(bounds.top_left, cell.width, cell.height)
          end
        end
      end
    end
  end

end