{
  description = "a smol godot c# rhythm game";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    uninix.url = "github:pulseflow/uninix/main";
    uninix.inputs.nixpkgs.follows = "nixpkgs";

    nixgl.url = "github:pulseflow/uninix/gl";
    nixgl.inputs.uninix.follows = "uninix";
    nixgl.inputs.nixpkgs.follows = "nixpkgs";

    leaflet.url = "github:pulseflow/leaflet/main";
    leaflet.inputs.uninix.follows = "uninix";
    leaflet.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, uninix, nixgl, leaflet, ... } @ inputs:
    uninix.lib.infer (inputs) (context: {
      context.plugins = [ nixgl.lib.uninix leaflet.lib.uninix ];
      context.internals.next.godot.enabled = true;
    });
}