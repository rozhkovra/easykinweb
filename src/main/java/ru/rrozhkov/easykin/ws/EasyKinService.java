package ru.rrozhkov.easykin.ws;

import javax.jws.WebMethod;
import javax.jws.WebService;

import ru.rrozhkov.easykin.context.EasyKinContext;
import ru.rrozhkov.easykin.model.category.ICategory;
import ru.rrozhkov.easykin.ws.category.CategoryBean;
import ru.rrozhkov.easykin.ws.category.convert.WSCategoryConverter;

@WebService(serviceName="EasyKin", portName="EasyKinPort", targetNamespace="http://rrozhkov.ru/easykin")
public class EasyKinService {

	@WebMethod
	public CategoryBean processCategory(int categoryId) {
		EasyKinContext context = new EasyKinContext();
		context.init();
		for(ICategory category : context.categories()){
			if(category.getId() == categoryId)
				return new WSCategoryConverter().convert(category);
		}
		return new CategoryBean();
	}
}
