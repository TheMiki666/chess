require_relative "../lib/piece.rb"

#Tests with a correct new piece
my_piece = Chess::Piece.new(0,'c5')
puts my_piece.color
puts my_piece.row
puts my_piece.col
puts my_piece.col_num #all correct

#Tests with another correct new piece

my_piece = Chess::Piece.new(1,'H8')
puts my_piece.color
puts my_piece.row
puts my_piece.col
puts my_piece.col_num #all correct

#Tests with another correct new piece
my_piece = Chess::Piece.new(0,'a1')
puts my_piece.color
puts my_piece.row
puts my_piece.col
puts my_piece.col_num #all correct

#Capturing my piece
my_piece.be_captured
puts my_piece.color
puts my_piece.row
puts my_piece.col
puts my_piece.col_num #all correct

#Situate directly the piece on the board
my_piece.situate_directly('e2')
puts my_piece.color
puts my_piece.row
puts my_piece.col
puts my_piece.col_num #all correct

#Trying to situate the piece directly on an impossible square must rise an TypeError
#my_piece.situate_directly('i5') #correct, rises the error
#my_piece.situate_directly('g0')#correct, rises the error
#my_piece.situate_directly('pato') #correct, rises the error

#Trying to execute empty methods must rise an NotImplementedError
#my_piece.can_move?('d4') #correct, rises the error
#my_piece.move('d4') #correct

#Trying to create a new piece with wrong arguments must rise an TypeError
#my_piece = Chess::Piece.new(2,'H8') #correct, wrong color
#my_piece = Chess::Piece.new(1,'nil') #correct, wrong square
#my_piece = Chess::Piece.new(1,'H10') #correct, wrong square
#my_piece = Chess::Piece.new(1,'K1') #correct, column
#my_piece = Chess::Piece.new(1,'H0') #correct, wrong row
my_piece = Chess::Piece.new(1,'H1') #correct, doesn't rise any error

#CLASS PIECE COMPLETLY TESTED
