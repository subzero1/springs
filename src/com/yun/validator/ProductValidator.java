package com.yun.validator;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.yun.entity.Product;

public class ProductValidator implements Validator {

	public boolean supports(Class<?> clazz) {
		// TODO Auto-generated method stub
		return false;
	}

	public void validate(Object target, Errors errors) {
		// TODO Auto-generated method stub
		Product product=(Product) target;
		ValidationUtils.rejectIfEmpty(errors, "name", "name.required");
		ValidationUtils.rejectIfEmpty(errors, "description", "description.required");
		ValidationUtils.rejectIfEmpty(errors, "price", "price.required");
		Float price=product.getPrice();
		if (price!=null&&price<=0) {
			errors.rejectValue("price", "price.required");
		}
	}

}
