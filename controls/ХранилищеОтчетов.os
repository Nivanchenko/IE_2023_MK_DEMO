#Использовать entity
#Использовать fs

Перем МенеджерСущностей;
Перем ФабрикаСущностей;

&Желудь
Процедура ПриСозданииОбъекта(
	
	&Деталька(Значение = "НастройкиПодключенияКБазеДанных.СтрокаСоединения")
	СтрокаСоединения,

	&Деталька(Значение = "НастройкиПодключенияКБазеДанных.ТипКоннектора")
	ТипКоннектора,

	&Пластилин(Значение = "Сущность", Тип = "ТаблицаЗначений") 
	ТаблицаСущностей
)

	ФабрикаСущностей = Новый Структура();
	МенеджерСущностей = Новый МенеджерСущностей(Тип(ТипКоннектора), 
												СтрокаСоединения);
	
	Для каждого ТекСущность Из ТаблицаСущностей Цикл
		МенеджерСущностей.ДобавитьКлассВМодель(ТекСущность.ОпределениеЖелудя.ТипЖелудя());
	КонецЦикла;
	
	МенеджерСущностей.Инициализировать();

	Для каждого ТекСущность Из ТаблицаСущностей Цикл
		ФабрикаСущностей.Вставить(Строка(ТекСущность.ОпределениеЖелудя.ТипЖелудя()),
									МенеджерСущностей.ПолучитьХранилищеСущностей(ТекСущность.ОпределениеЖелудя.ТипЖелудя())
		);
	КонецЦикла;

КонецПроцедуры

Функция ЗаписатьНовыйОтчет(Пользователь, Ошибка, Комментарий) Экспорт

	Отчет = ФабрикаСущностей.ОписаниеОтчетаОшибки.СоздатьЭлемент();
	Отчет.Пользователь = Пользователь;
	Отчет.Ошибка = Ошибка;
	Отчет.Комментарий = Комментарий;
	Отчет.Дата = ТекущаяДата();

	Попытка
		Отчет.Сохранить();	
	Исключение
		Сообщить(ОписаниеОшибки());
	КонецПопытки;
	

	Возврат Строка(Отчет.Идентификатор);
	
КонецФункции

Функция ПолучитьОтчеты() Экспорт
	Возврат МенеджерСущностей.Получить(Тип("ОписаниеОтчетаОшибки"));
КонецФункции

Функция ПолучитьОтчетПоИдентификатору(Идентификатор) Экспорт
	Возврат МенеджерСущностей.ПолучитьОдно(Тип("ОписаниеОтчетаОшибки"), Число(Идентификатор));
КонецФункции