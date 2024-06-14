{
  programs.nixvim = {
    plugins = {
      rust-tools = {
        enable = true;
        inlayHints = {
          auto = true;
          showParameterHints = false;
          parameterHintsPrefix = "";
          otherHintsPrefix = "";
        };

        server = {
          lens.enable = true;
          procMacro.enable = true;
          check = {
            allTargets = false;
            command = "clippy";
          };
          inlayHints = {
            lifetimeElisionHints = {
              enable = "always";
              useParameterNames = false;
            };
            reborrowHints = {
              enable = "always";
            };
            bindingModeHints = {
              enable = false;
            };
            chainingHints = {
              enable = false;
            };
            closingBraceHints = {
              enable = false;
              minLines = 25;
            };
            closureReturnTypeHints = {
              enable = "never";
            };
            parameterHints = {
              enable = false;
            };
            renderColons = true;
            typeHints = {
              enable = false;
              hideClosureInitialization = false;
              hideNamedConstructor = false;
            };
          };
        };
      };
    };

  };
}
