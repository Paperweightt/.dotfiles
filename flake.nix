{
  description = ".dotfiles";

  outputs = { self }: {
    nvim = self "path:./nvim";
  };
}
