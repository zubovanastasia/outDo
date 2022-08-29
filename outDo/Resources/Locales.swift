//
//  Locales.swift
//  outDo
//
//  Created by Антон Бондаренко on 31.07.2022.
//

import Foundation

struct LocalesPattern {
    
    static let value = "%value%"
}

final class Locales {
    
    static var current = "ru_RU"
    static var currentShort = "ru" // for picker
    
    static func value(_ key: String) -> String {
        return data[key] ?? ""
    }
    
    static func valueFor(_ state: TTaskState) -> String {
        return taskStateData[state] ?? ""
    }
                    
    static private let taskStateData: [TTaskState:String] = [
        .created : "Приступить к выполнению",
        .cancelled : "Отменена",
        .completed : "Завершена",
        .processed : "В процессе выполнения"
    ]
    
    static private let data: [String:String] = [
        "apiErrorText_signInByPassword": "Ошибка входа",
        "apiErrorText_signUp": "Ошибка регистрации",
        
        "alert_text_signUpSuccess": "Пользователь успешно создан. Теперь вы можете войти.",
        "alert_text_signOut": "Вы уверены, что хотите выйти из учетной записи?",
        "alert_title_auth": "Профиль",
        
        "dialog_button_yesSignOut": "Да, выйти",
        "dialog_button_no": "Нет",
        "dialog_button_close": "Закрыть",
        "dialog_button_save": "Сохранить",
        "dialog_button_cancel": "Отменить",
        
        "navbar_create": "Создать",
        
        "navigationDrawer_app": "О приложении",
        "navigationDrawer_policy": "Политика конфиденциальности",
        
        "popup_dialogPicker_title": "Дата",
        
        "toast_taskCreate_noTitle": "Введите название задачи",
        "toast_taskCreate_noDate": "Добавьте время",
        "toast_signUpWrongConfirm": "Пароли не совпадают",
        "toast_signUpWrongLogin": "Введите корректную почту (логин)",
        "toast_signUpWrongName": "Введите имя",
        "toast_signUpWrongPassword": "Введите корректный пароль",
        "toast_wrongLoginPassword": "Ошибка логин/пароля",
        
        "vc_about_title": "О приложении",
        "vc_about_text": "Мы сделали всё для повышения эффективности управления своего времени и планирования. \n\n\"outDo\" поможет сконцентрироваться на главном и не забыть о важном деле.\n\nНастривайте свои задачи, делитесь ими со своими друзьями и коллегами.\n\nКоманда \"outDo\"\nПо всем вопросам и предложениям support@out.do\n\n©outDo 2022",
        
        "vc_login_login": "Логин (почта)",
        "vc_login_password": "Пароль",
        "vc_login_signIn": "Войти",
        
        "vc_main_title": "Мои задачи",
        
        "vc_profile_title": "Профиль",
        "vc_profile_name": "Имя",
        "vc_profile_email": "Почта",
        "vc_profile_signOut": "Выйти",
        
        "vc_task_fromDate": "Время начала",
        "vc_task_title": "Задача #%value%",
        "vc_task_description": "Описание",
        
        "vc_taskCreate_title": "Новая задача",
        "vc_taskCreate_name": "Название",
        "vc_taskCreate_date": "Время начала",
        "vc_taskCreate_desc": "Описание",
        
        "vc_signUp_login": "Почта",
        "vc_signUp_name": "Имя",
        "vc_signUp_password": "Пароль",
        "vc_signUp_confirmPassword": "Подтвердите пароль",
        "vc_signUp_button": "Зарегистрироваться",
    ]
}

// ‒
// •
// →
