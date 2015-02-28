-- Textadept config
--
-- A fast, minimalist, and extensible cross-platform text editor
--
-- http://foicica.com/textadept/
-- http://foicica.com/textadept/manual.html

-- Set theme to dark in GUI mode and custom_term in terminal mode.
ui.set_theme(not CURSES and 'dark' or 'custom_term')
