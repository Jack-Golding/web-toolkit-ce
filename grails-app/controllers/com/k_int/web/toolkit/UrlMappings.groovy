package com.k_int.web.toolkit

class UrlMappings {

  static mappings = {
    "/kiwt/config/$extended?" (controller: 'config' , action: "resources")
    "/kiwt/config/schema/$type" (controller: 'config' , action: "schema")
    "/kiwt/config/schema/embedded/$type" (controller: 'config' , action: "schemaEmbedded")
    
    "/ref/blank/$domain/$prop" (controller: 'ref', action: 'blank')
  }
}
