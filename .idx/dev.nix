# To learn more about how to use Nix to configure your environment
# see: https://developers.google.com/idx/guides/customize-idx-env
{ pkgs, ... }: {
  # Which nixpkgs channel to use.
  channel = "stable-24.11"; # or "unstable"
  # Use https://search.nixos.org/packages to find packages
  packages = [
    pkgs.htop
    pkgs.nano
    pkgs.uv
  ];
  # Sets environment variables in the workspace
  env = {
    AIDER_SHOW_MODEL_WARNINGS = "FALSE";
    AIDER_SHOW_RELEASE_NOTES = "FALSE";
    OPENAI_API_KEY = "...";
    GEMINI_API_KEY = "...";
  };
  idx = {
    # Search for the extensions you want on https://open-vsx.org/ and use "publisher.id"
    extensions = [
      # "vscodevim.vim"
    ];
    # Enable previews
    previews = {
      enable = false;
      previews = {
        web = {
          # Example: run "npm run dev" with PORT set to IDX's defined port for previews,
          # and show it in IDX's web preview panel
          command = ["python" "-m" "http.server"];
          manager = "web";
        };
      };
    };
    # Workspace lifecycle hooks
    workspace = {
      # Runs when a workspace is first created
      onCreate = {
        aider-install = "uv tool install --force --python python3.12 aider-chat@latest";
        ln-python = "ln -s ~/.local/share/uv/python/$(ls ~/.local/share/uv/python/)/bin/python3.12 ~/.local/bin/python";
        ln-python3 = "ln -s ~/.local/share/uv/python/$(ls ~/.local/share/uv/python/)/bin/python3.12 ~/.local/bin/python3";
        add-local-bin-path = "echo 'export PATH=\"/home/user/.local/bin:$PATH\"' | tee --append ~/.bashrc";
        # Open editors for the following files by default, if they exist:
        default.openFiles = [ ".idx/dev.nix" ];
      };
      # Runs when the workspace is (re)started
      onStart = {
        # aider-architect = "aider --architect --yes-always";
        # Example: start a background task to watch and re-build backend code
        # watch-backend = "npm run watch-backend";
      };
    };
  };
}
