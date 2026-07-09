{ lib, ... }: let
  # Define/get host identifier
  getHostId = host: {
    "lux"     = "l";
    "nova"    = "n";
    "vm"      = "n";
    "astore"  = "a";
    "medea"   = "m";
    "engrit"  = "e";
  }.${host};

  # Prefixes a key in an attribute set
  prependAttrs = prefix:
    lib.attrsets.mapAttrs' (name: value:
      lib.attrsets.nameValuePair "${prefix}${name}" value);

  # Look up a nested attribute using a list of attributes (ex. ["foo", "bar", "baz"])
  getAttrByList = set: pathList:
    if pathList == [] then set
    else getAttrByList (set.${builtins.head pathList}) (builtins.tail pathList) ;

  # Look up a nested attribute using a dot-separated string (ex. "foo.bar.baz")
  getAttrByStr = set: pathStr:
    let
      _path = builtins.split "\\." pathStr;
      path = builtins.filter (x: x != []) _path;
    in
      getAttrByList set path;
in {
  inherit getHostId prependAttrs getAttrByList getAttrByStr;
}
