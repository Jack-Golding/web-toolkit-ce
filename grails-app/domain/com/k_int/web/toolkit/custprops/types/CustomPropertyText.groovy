package com.k_int.web.toolkit.custprops.types

import com.k_int.web.toolkit.custprops.CustomProperty

import grails.gorm.MultiTenant
import grails.gorm.annotation.Entity

@Entity
class CustomPropertyText extends CustomProperty<String> implements MultiTenant<CustomPropertyText> { 
  
  String value
  
  static constraints = {
    value nullable: false, blank: false, type:'text'
  }
  
}
