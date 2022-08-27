//
//  Locales.swift
//  outDo
//
//  Created by Антон Бондаренко on 31.07.2022.
//

import Foundation

final class Locales {
    
    static var current = "ru_RU"
    static var currentShort = "ru" // for picker
    
    static func value(_ key: String) -> String {
        return data[key] ?? ""
    }
    
    static private let data: [String:String] = [
        "apiErrorText_signInByPassword": "Ошибка входа",
        "apiErrorText_signUp": "Ошибка регистрации",
        
        "alert_text_signUpSuccess": "Пользователь успешно создан. Теперь вы можете войти.",
        "alert_title_auth": "Профиль",
        
        "dialog_button_close": "Закрыть",
        
        "navigationDrawer_app": "О приложении",
        "navigationDrawer_policy": "Политика конфиденциальности",
        
        "toast_signUpWrongConfirm": "Пароли не совпадают",
        "toast_signUpWrongLogin": "Введите корректную почту (логин)",
        "toast_signUpWrongName": "Введите имя",
        "toast_signUpWrongPassword": "Введите корректный пароль",
        "toast_wrongLoginPassword": "Ошибка логин/пароля",
        
        "vc_login_login": "Логин (почта)",
        "vc_login_password": "Пароль",
        "vc_login_signIn": "Войти",
        
        "vc_main_title": "Мои задачи",
        
        "vc_signUp_login": "Почта",
        "vc_signUp_name": "Имя",
        "vc_signUp_password": "Пароль",
        "vc_signUp_confirmPassword": "Подтвердите пароль",
        "vc_signUp_button": "Зарегистрироваться",
        "vc_edit_button": "Изменить",
        
//        "vc_critical_title": "Sorry, critical data error",
//        "vc_critical_title_internet": "No Internet connection available",
//
//
//        "vc_profile_title": "PROFILE",
//        "vc_profile_prompt_email": "Email",
//        "vc_profile_prompt_firstname": "First name",
//        "vc_profile_prompt_lastname": "Last name",
//        "vc_profile_prompt_birthday": "Birthday",
//        "vc_profile_prompt_phone": "Phone"
    ]
}

// ‒
// •
// →
