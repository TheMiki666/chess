
require_relative "../lib/piece.rb"

#Tests with a correct new piece
my_piece = Chess::Piece.new(0,3,5)
puts my_piece.color
puts my_piece.row
puts my_piece.col
puts my_piece.col_letter #all correct
puts "-----"

#Tests with another correct new piece

my_piece = Chess::Piece.new(1,8,1)
puts my_piece.color
puts my_piece.row
puts my_piece.col
puts my_piece.col_letter #all correct
puts "-----"

#Tests with another correct new piece
my_piece = Chess::Piece.new(0,1,8)
puts my_piece.color
puts my_piece.row
puts my_piece.col
puts my_piece.col_letter #all correct
puts "-----"

#Capturing my piece
my_piece.be_captured
puts my_piece.color
puts my_piece.row
puts my_piece.col
puts my_piece.col_letter #all correct
puts "-----"

#Situate directly the piece on the board
my_piece.situate_directly(5,2)
puts my_piece.color
puts my_piece.row
puts my_piece.col
puts my_piece.col_letter #all correct
puts "-----"

#Trying to situate the piece directly on an impossible square must rise an TypeError
#my_piece.situate_directly(9,1) #correct, rises the error
#my_piece.situate_directly(1,9)#correct, rises the error
#my_piece.situate_directly(0,8) #correct, rises the error
#my_piece.situate_directly(8,0) #correct, rises the error
#my_piece.situate_directly('c',2) #correct, rises the error
#my_piece.situate_directly(3,2.0) #correct, rises the error

#Trying to execute empty methods must rise an NotImplementedError
#my_piece.can_move?(4,4, nil) #correct, rises the error
#my_piece.move(4,4, nil) #correct

#Trying to create a new piece with wrong arguments must rise an TypeError
#my_piece = Chess::Piece.new(2, 8, 8) #correct, wrong color
#my_piece = Chess::Piece.new(nil, 8, 8) #correct, wrong color
#my_piece = Chess::Piece.new(1, 9, 1) #correct, wrong column
#my_piece = Chess::Piece.new(1,'H',8) #correct, wrong column
#my_piece = Chess::Piece.new(1, 1, -1) #correct, wrong row
#my_piece = Chess::Piece.new(1, 8, 'king') #correct, wrong row
my_piece = Chess::Piece.new(1,8,1) #correct, doesn't rise any error

#CLASS PIECE COMPLETLY TESTED
