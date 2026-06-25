# Terminal greeter. Sourced by ~/.zshrc.
# Renders ~/.config/zsh/logo.png on shell start if chafa + the image exist.
# chafa auto-detects the terminal's graphics support (Ghostty → Kitty protocol,
# Windows Terminal → Sixel, else Unicode blocks) and honors PNG transparency,
# so the see-through areas show your terminal background.
#
# Add your own art:  cp logo.png ~/.config/zsh/logo.png && chezmoi add ~/.config/zsh/logo.png
# Size: --scale 1.0 ≈ the image's native pixel size; lower (e.g. 0.5) = smaller.
# Show only on login shells instead of every tab: change `*i*` test to `-o login`.
if [[ $- == *i* ]] && command -v chafa &>/dev/null; then
  _logo="$HOME/.config/zsh/logo.png"
  [[ -f "$_logo" ]] && chafa --scale 1.0 "$_logo"
  unset _logo
fi
