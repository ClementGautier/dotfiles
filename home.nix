{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.sofka.homeManagerModules.default
  ];

  home.username = "clement";
  home.homeDirectory = "/home/clement";
  home.stateVersion = "26.05"; # Garder la version d'origine lors de la création
  home.sessionVariables = {
    VM_METRICS_URL = "http://localhost:8428";
    VM_LOGS_URL = "http://localhost:9428";
    VM_ALERTMANAGER_URL = "http://localhost:9093";
    EDITOR = "nvim";
  };
  home.packages = with pkgs; [
    git
    gh
    ripgrep   # fast search
    fd        # fast find
    fzf       # fuzzy finder
    jq        # json on the command line
    lazygit
    neovim
    herdr
    opencode
    nerd-fonts.hack
    kubectl
    fluxcd
    kubernetes-helm
    nodejs_26
    kustomize
    s3cmd
  ];

  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Clement Gautier";
        email = "clement.gautier.76@gmail.com";
      };
      alias = {
        oups = "commit -a --amend -C HEAD";
        br = "branch -v";
        bra = "branch -v -a";
        cat = "cat-file -p";
        cc = "shortlog -sn";
        ci = "commit -v";
        cia = "commit --amend -C HEAD";
        ciaa = "commit -a --amend -C HEAD";
        cim = "commit -m '--'";
        co = "checkout";
        count = "shortlog -sn";
        d = "diff";
        ds = "diff --staged";
        dis = "diff --ignore-all-space";
        last = "log -1 HEAD";
        lg = "log --graph --pretty=tformat:'%Cred%h%Creset -%C(cyan)%d %Creset%s %Cgreen(%an %cr)%Creset' --abbrev-commit --date=relative";
        lga = "log --graph --pretty=tformat:'%Cred%h%Creset -%C(cyan)%d %Creset%s %Cgreen(%an %cr)%Creset' --abbrev-commit --date=relative --all";
        logfull = "log --pretty=fuller --graph --stat -p";
        rebc = "rebase --continue";
        rebs = "rebase --skip";
        rebt = "rebase --abort";
        st = "status";
        uncommit = "reset --soft HEAD^";
        uncommithard = "reset --hard HEAD^";
        undomerge = "reset --hard ORIG_HEAD";
        unstage = "reset HEAD";
        pick = "cherry-pick";
        picka = "cherry-pick --abort";
        pickc = "cherry-pick --continue";
        file = "show --stat --oneline";
        stream = "push --set-upstream origin";
      };
      core = {
        excludesfile = "~/.gitignore";
      };
      help = {
        autocorrect = 1;
      };
    };
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;      # ghost text from history
    syntaxHighlighting.enable = true;  # commands turn green when valid
    initContent = ''
      bindkey '^f' autosuggest-accept
    '';
    shellAliases = {
      ".." = "cd ..";
      week = "date +%V";
      myip = "dig +short myip.opendns.com @resolver1.opendns.com";
      cc = "opencode";
    };
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      format = "$directory$git_branch$git_status$cmd_duration$line_break$character";
      character = {
        success_symbol = "[❯](purple)";
        error_symbol = "[❯](red)";
      };
      cmd_duration.format = "[$duration]($style) ";
    };
  };

  programs.sofka = {
    enable = true;
  };

  home.file.".config/wezterm".source =
    config.lib.file.mkOutOfStoreSymlink "/home/clement/Projects/dotfiles/.config/wezterm";
  home.file.".config/nvim".source =
    config.lib.file.mkOutOfStoreSymlink "/home/clement/Projects/dotfiles/.config/nvim";
}
