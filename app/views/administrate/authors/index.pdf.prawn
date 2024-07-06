# myproducts.pdf.prawn

# prawn_document do |pdf|
#     pdf.text("Listando autores:")
#     pdf.move_down(20)
#     pdf.table @authors.collect{|p| [p.id,p.name]}
# end

prawn_document do |pdf|
    pdf.text("Listando autores:")
    pdf.move_down(20)
  
    # Adiciona o cabeçalho à tabela
    header = [["ID", "Nome"]]
    data = header + @authors.collect { |p| [p.id, p.name] }
  
    pdf.table(data, header: true) do |table|
      table.row(0).style(background_color: 'D3D3D3', font_style: :bold) # Estilo para o cabeçalho
    end
  end
  