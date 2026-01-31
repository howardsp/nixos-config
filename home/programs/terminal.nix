{ config, lib, pkgs, ... }:

{
  # Alacritty terminal
  programs.alacritty = {
    enable = true;
    
    settings = {
      # Window
      window = {
        padding = {
          x = 10;
          y = 10;
        };
        decorations = "full";
        opacity = 0.95;
        dynamic_title = true;
      };
      
      # Scrolling
      scrolling = {
        history = 10000;
        multiplier = 3;
      };
      
      # Font
      font = {
        normal = {
          family = "JetBrains Mono";
          style = "Regular";
        };
        bold = {
          family = "JetBrains Mono";
          style = "Bold";
        };
        italic = {
          family = "JetBrains Mono";
          style = "Italic";
        };
        size = 12.0;
      };
      
      # Colors (Catppuccin Mocha)
      colors = {
        primary = {
          background = "#1e1e2e";
          foreground = "#cdd6f4";
          dim_foreground = "#7f849c";
          bright_foreground = "#cdd6f4";
        };
        
        cursor = {
          text = "#1e1e2e";
          cursor = "#f5e0dc";
        };
        
        vi_mode_cursor = {
          text = "#1e1e2e";
          cursor = "#b4befe";
        };
        
        search = {
          matches = {
            foreground = "#1e1e2e";
            background = "#a6adc8";
          };
          focused_match = {
            foreground = "#1e1e2e";
            background = "#a6e3a1";
          };
        };
        
        normal = {
          black = "#45475a";
          red = "#f38ba8";
          green = "#a6e3a1";
          yellow = "#f9e2af";
          blue = "#89b4fa";
          magenta = "#f5c2e7";
          cyan = "#94e2d5";
          white = "#bac2de";
        };
        
        bright = {
          black = "#585b70";
          red = "#f38ba8";
          green = "#a6e3a1";
          yellow = "#f9e2af";
          blue = "#89b4fa";
          magenta = "#f5c2e7";
          cyan = "#94e2d5";
          white = "#a6adc8";
        };
      };
      
      # Cursor
      cursor = {
        style = {
          shape = "Block";
          blinking = "On";
        };
        blink_interval = 750;
      };
      
      # Shell
      shell = {
        program = "${pkgs.zsh}/bin/zsh";
      };
      
      # Key bindings
      keyboard.bindings = [
        { key = "V"; mods = "Control|Shift"; action = "Paste"; }
        { key = "C"; mods = "Control|Shift"; action = "Copy"; }
        { key = "Plus"; mods = "Control"; action = "IncreaseFontSize"; }
        { key = "Minus"; mods = "Control"; action = "DecreaseFontSize"; }
        { key = "Key0"; mods = "Control"; action = "ResetFontSize"; }
      ];
    };
  };

  # Kitty terminal (alternative)
  programs.kitty = {
    enable = false;  # Disabled by default, enable if preferred
    
    font = {
      name = "JetBrains Mono";
      size = 12;
    };
    
    settings = {
      background_opacity = "0.95";
      confirm_os_window_close = 0;
      enable_audio_bell = false;
      
      # Tab bar
      tab_bar_edge = "top";
      tab_bar_style = "powerline";
      
      # Colors
      foreground = "#cdd6f4";
      background = "#1e1e2e";
      
      # Cursor
      cursor = "#f5e0dc";
      cursor_shape = "block";
      cursor_blink_interval = 0.75;
    };
  };
}
