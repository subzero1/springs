package com.yun.controler;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.yun.entity.Product;
import com.yun.entity.ProductForm;

@Controller
public class ProductControler {
	@RequestMapping("productInput.do")
	public String inputProduct() {
		return "productForm";
	}

	@RequestMapping("productInput2.do")
	public ModelAndView inputProduct2() {
		ModelAndView view = new ModelAndView();
		view.setViewName("productFormBind");

		return view;
	}

	@RequestMapping("productTestJson.do")
	public String testJson() {
		return "productTestJson";
	}

	@RequestMapping("productSave.do")
	public String saveProduct(ProductForm productForm,
			RedirectAttributes redirectAttributes) {
		Product product = new Product();
		product.setDescription(productForm.getDescription());
		product.setName(productForm.getName());
		try {
			product.setPrice(Float.parseFloat(productForm.getPrice()));
		} catch (Exception e) {
			// TODO: handle exception
		}
		redirectAttributes.addFlashAttribute("product", product);
		return "redirect:/productView.do" + 433;
	}

	@RequestMapping(value = "productView.do")
	public String viewProduct(Long id, Model model) {
		Product product = new Product();
		product.setId(id);
		return "productDetail";
	}

	@RequestMapping(value = "productSave2.do")
	public String productSave2(@ModelAttribute Product product, Model model) {
		return "productDetail";
	}

	// 测试json
	@RequestMapping("jsonTest.do")
	public 
	@ResponseBody
	Product name(@ModelAttribute Product product) {

		return product;

	}
	
	@RequestMapping("test.do")
	public String test() {
		return "productForm";
	}

}
