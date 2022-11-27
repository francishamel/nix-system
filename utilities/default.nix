{ filterAttrs, mapAttrs' }:

{
  /* `mapFilterAttrs`, composition of filter and map attrset transformations.
     Type: mapFilterAttrs :: (name -> value -> { name = any; value = any; })
                             (name -> value -> bool )
                             Attrset
  */
  mapFilterAttrs = f: seive: attrs: mapAttrs' f (filterAttrs seive attrs);
}
