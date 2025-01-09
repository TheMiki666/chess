# chess
Chess Game - Final Project of Ruby Course from The Odin ProjectOdin's Chess

#Build a command line chess game where two players can play against each other.

Done!

#The game must be properly restricted - it must prevent players from making illegal moves and declare check or checkmate in the right situations.

Also done. The game complies with the basic rules set by the International Chess Federation (FIDE). In addition to the pieces moving as they should, the game implements:
- Check and checkmate
- Impossibility of leaving your king in check
- Castling
- En passant pawn capture
- Pawn promotion (the player can choose the piece from the four possible)
As for draws, these possible draw conditions are implemented:
- Stalemate king (of course!)
- Rule of 50/75 consecutive moves without capturing or moving a pawn (with 50 moves the player can demand a draw, with 75 the draw is automatic)
- Insufficient material. Automatic draws occur if one of these situations occurs:
* King vs. king
* King vs. king and knight
* King vs. king and bishop
* King and bishop vs. king and bishop, when the bishops are on squares of the same color
(If a team has more than one bishop, but they are on squares of the same color, it counts as a single bishop on a square of that color.)
- Draws by mutual agreement

These draws are NOT implemented:
- Photographic draw (threefold and fivefold). They could be implemented in the future (we will explain how at the end of this readme).
- Material shortage situations where checkmate is theoretically possible, but which in practice would mean that the losing player must deliberately play to lose (for example, king and bishop vs. king and knight, or king vs. king and two knights). FIDE does not recognize automatic draws in these cases, but invites both players to sign a draw by mutual agreement.
- Dead positions (where it is impossible for either player to achieve checkmate) where there is no shortage of material:

https://en.wikipedia.org/wiki/Rules_of_chess#Dead_position

This last case is not only not implemented, but there is no intention to do so either (it would require a lot of AI calculations that exceed the objective of this exercise).

#Make it so you can save the board at any time (remember how to serialize?)

Yes, I remember. The saving and loading of the game is implemented. As a curiosity, I will point out that it is not the board with the pieces that is saved, but the log of the moves. When a game is loaded, what is done is to retrieve this log and, automatically, the computer starts a new game from scratch and initially makes the moves recorded. In addition, this log is a JSON file that is easy to read and even to modify; you could create this log yourself with a few initial moves (an opening, for example), and start a new game based on these moves.

During the game we can consult the game log; but it does not appear in JSON format, but in chess algebraic notation, so that humans can understand it more easily.

I have implemented a system of 9 slots in each of which you can have a game saved. If these slots are filled, they can be overwritten (the program warns you about this in case you change your mind).

Completed games can be saved (either checkmate or forced draw). The game can be loaded, but cannot be continued; only the board and the log (in algebraic notation) are allowed to be viewed.

If the game ends by resignation of one of the players, by a draw by mutual agreement, or by a draw after 50 moves without capturing a piece or moving a pawn (but less than 75 moves), the game can be saved and, later, it could be loaded and played on.

You can type 'save' during the game to save it, but not load a new one (it does not respond to the 'load' command); to do this you would have to exit to the main menu, resign, propose a draw, or exit the program to the operating system and enter again. Before starting a new game, the system will offer you, instead of starting a new game from scratch, to load a saved game (if one is available).

In addition to being able to type 'save' during the game, the system will offer you the option of saving it voluntarily when:
- You quit the program ('quit' command).
- You surrender ('resing' command).
- You propose or demand a draw ('draw' command) and the opponent or the referee (system) accepts it.
- The game ends with a checkmate or a mandatory draw.
...provided that at least one valid move has been made since the last save, load or start of the game. If not, it does not offer it.

#Write tests for the important parts. You don't need TDD (unless you want to), but make sure you use RSpec tests for anything you write on the command line repeatedly.
Do your best to keep your classes modular and clean and your methods doing only one thing each. This is the largest program you've ever written, so you'll definitely start to see the benefits of good organization (and testing) when you start running into bugs.

The program is not TDD, in the sense that I built the classes and methods first, and then I tested them. And yes, I did a lot, a lot of testing (much more than production code), a good part of which is done with Rspec (especially unit tests, or when there are only a few classes involved). I've tried to go slowly, step by step, walking carefully, to avoid escalating bugs as much as possible.
I've done three types of tests:
1. Tests with Rspec
2. Visual tests (drawing the board and seeing how the pieces move on it, or which squares were threatened, or what textual response is displayed on the screen, ).
3. Comprehensive tests using playable games.

I've also modified methods or even created specific methods for testing, which are not used in the production code. For example, the Board class has a method, #analize_visual_check, which displays the drawing of the board on the screen but without pieces, marking the threatened squares with an "x". Or the Referee#print_log method: if you pass it "true" as an optional parameter, it shows you the hash with the log of moves instead of in algebraic notation.

#Not familiar with chess? Check out some of the additional resources to help you get your bearings.

Don't worry: I've been playing since I was a kid, and that's helped me a lot.

#Have fun! Check out Wikipedia's Unicode chess characters to spice up your game board a bit.

Yes: I used those characters. Thanks a lot.

#Extra Credit
Build a very basic AI computer player (that maybe makes a random legal move).

I haven't implemented it; I'm looking forward to continuing with Project Odin, and I don't want to get too far behind. But I've prepared the code so that it can be done in the future. Then we'll see how it could be done.
-----------

# Description of the classes and how the program works:

- Piece class: is the class from which the concrete pieces (pawn, knight, etc.) inherit. It has three "abstract" methods, which must be implemented by said stones: #can_move?, which indicates whether a piece can move or not to a certain square; #can_capture?, which indicates whether it can capture on a certain square (it differs from #can_move? in pawns); and #move, which moves the piece.
- Pawn, Knight, Bishop, Rook, Queen and King classes: implement the methods previously seen. Rooks and kings also have the @status property, which indicates whether they have moved previously (for castling), and whether they can be captured en passant in the case of pawns.
- Board class: saves the position of the pieces on the board, and also the turn of the player whose turn it is to move. It also saves the real record (Hash with the moves) of the game. It has methods to remove pieces from the board, move them from one square to another, create new pieces or make copies of existing ones.
-Referee class: controls that the game is played according to the rules of chess. It analyzes the move that is to be made and executes it if it is valid. It is the one who executes the special moves (castling, en passant capture and promotion). It prohibits moves that leave the king in check, and determines if a situation is check, checkmate, stalemate or another type of mandatory draw. It keeps the move counter and the false register (the moves in algebraic notation).
-UserInterface class: manages and filters user input, as well as screen output (removing the drawing of the board, which is carried out directly by the Board class).
-GameManager class: controls the parts of the program that are not the game itself: the main menu, the recording and loading of games, etc.

I must admit that one weak point of the program is the communication between classes: it could be better organized. Sometimes the referee class communicates directly with the UserInterface, sometimes it does so through GameManager, etc... Even though the game works, it's possible that this little mess can make it difficult to scale.

Hopefully in the Rails course we'll learn something about architecture of large software projects!

-----------------------
# Improvements to implement in the future:
1. Photographic draw (treefold and fivefold). For this you need:
- A method to determine if two pieces are equal (if they are the same figure, the same color, are on the same square on the board and have the same status.
- A method to clone the board
- A method to determine if two boards are equal (when all their pieces are equal, and their player turn is equal; it should not affect their record, nor the move number they are on).
- A record that saves a new board (a photo of the board) with each valid move.
- A method that compares the board with all previous photos, and warns when there are three or five repeated boards; it is probably much more efficient to compare the boards with hashes and only when they match to make a thorough comparison of the boards.

2. Basic AI (chooses random moves).
The Referee#analize_turn method is implemented to analyze automated moves (in fact, it does so when we update the board by loading a recorded log). So it can analyze and execute moves generated by an AI.
To make this AI random, we could have it match all the pieces left on the board with all the squares on the board. In the worst case, which is at the beginning of the game, these would be the results:
16 x 64 = 1024 combinations
Then we would eliminate those moves that were not allowed.
Among the resulting allowed moves, we would choose one at random. The Referee would analyze it, and if it is not legal (for example, it puts the king in check), we would eliminate it and choose another one.

# AND I HAVE FINALLY FINISHED THE RUBY COURSE!


