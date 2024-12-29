module Chess
  class InputManager
    ORD_CONSTANT = 96

    #TODO: CAMBIA ESTA FUNCIÓN PARA ACOMODARLA A LA ENTRADA DEL USUARIO
    def self.filter_square(square)
      error = false
      if !square.is_a?(String) || square.length != 2 
        error = true
      else
        col = square[0].downcase
        row = square[1].to_i
        if !row.is_a?(Integer) || row < 1 || row > 8 || col < 'a' || col > 'h'
          error = true
        else
          return [col.ord - ORD_CONSTANT, row]
        end
      end
      raise TypeError.new "#{self.class} square is #{square}, when must be 'a1' to 'h8'" if error
    end
  end
end