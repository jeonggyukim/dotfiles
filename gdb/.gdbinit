set confirm off
set verbose off
set history filename ~/.gdb_history
set history save

# These make gdb never pause in its output
set height 0
set width 0

define cls
  shell clear
end
document cls
Clears the screen with a simple command.
end
