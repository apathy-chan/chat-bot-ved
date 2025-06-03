INSERT INTO questions (section_id, question, answer, content_type) VALUES
-- Раздел "Работа с электронной подписью"
('signature', 'Нужна ли мне ЭП или достаточно войти в ЛК через Госуслуги?', 
'<div class="answer-content">
  <p>Начнем с того, что большинство сервисов Личного кабинета (ЛК) предназначены для юридических лиц (ЮЛ) и индивидуальных предпринимателей (ИП) (далее про ЮЛ и ИП говорим - организации).</p>
  <p>Для кого предназначен сервис и нужна ли для него ЭП, см. в разделе Справки <a href="https://edata.customs.ru/FtsPersonalCabinetWeb2017/Help/#?topic=Nuzhna_EP&src=Help" target="_blank">Определите, требуется ли вам для работы электронная подпись</a>.</p>
  <p>Для работы с сервисами для организаций - в вашем ЛК обязательно должна быть подтверждена организация.</p>
  <img src="https://edata.customs.ru/FtsPersonalCabinetWeb2017/Service/GetFile?src=ep_confirmation.png" alt="Подтверждение организации" style="max-width:100%;">
</div>', 
'html'),

('signature', 'Не устанавливается/не работает плагин для работы с ЭП', 
'<div class="answer-content">
  <p>Если вы установили плагин Крипто-Про ЭЦП Browser Plug-in, но всё равно на сайте появляется сообщение с предложением его установки, выполните следующую последовательность действий:</p>
  <ol>
    <li>Перед новой установкой удалите плагин(ы), который вы устанавливали в прежних попытках через <strong>Панель управления → Программы и компоненты</strong></li>
    <li>Почистите кэш браузера</li>
    <li>Скачайте и запустите плагин заново под правами администратора</li>
    <li>Перезагрузите компьютер сразу после установки</li>
  </ol>
  <p>Если проблема сохраняется, обратитесь в <a href="https://cryptopro.ru/support" target="_blank">техническую поддержку КриптоПро</a>.</p>
</div>', 
'html'),

-- Раздел "Лицевой счет"
('account', 'Как открыть лицевой счёт?', 
'<div class="answer-content">
  <p>ЛС открывается автоматически при перечислении денежных средств в таможенные органы.</p>
  <p>Платежи по ЛС вносятся на счет таможенного органа по коду «10000010» (поле 107 п/п).</p>
  <p><a href="https://customs.gov.ru/uchastnikam-ved/uplata-tamozhennyx-i-inyx-platezhej/rekvizity-scheta-dlya-perechisleniy" target="_blank">Реквизиты счета для оплаты таможенных платежей.</a></p>
  <p>Порядок открытия единого лицевого счета отражен в приказе ФТС России от 29.04.2019 № 727</p>
</div>', 
'html'),

('account', 'Как выгрузить Подтверждение уплаты таможенных пошлин, налогов и Отчет о расходовании денежных средств, внесенных в качестве авансовых платежей в Excel?', 
'<div class="answer-content">
  <p>Откройте на просмотр полученный от ТО ответ. Нажмите кнопку Печать, после этого в открывшемся окне будет доступна кнопка XLS.</p>
  <p class="note">К сведению! В Excel выгружается только табличная часть!</p>
  <img src="https://edata.customs.ru/FtsPersonalCabinetWeb2017/Service/GetFile?src=blobid1557231420799.gif" alt="Процесс выгрузки в Excel" style="max-width:100%;">
</div>', 
'html'),

-- Продолжение для остальных разделов...
('pre-info', 'Как подать ПИ в объём ДТ?', 
'<div class="answer-content">
  <p>В случае предварительного декларирования в ПИ указываются:</p>
  <ul>
    <li>все обязательные поля, помеченные красной звёздочкой</li>
    <li>рег.номер ПТД на вкладке Сведения о товарной партии</li>
  </ul>
  <img src="https://edata.customs.ru/FtsPersonalCabinetWeb2017/Service/GetFile?src=01.png" alt="Подача ПИ в объём ДТ" style="max-width:100%;">
</div>', 
'html'),

-- Остальные вопросы...
('archive', 'Как добавить изображение или файл pdf в архив?', 
'<div class="answer-content">
  <p>Изображение добавляется в Электронный архив в виде документа «Бинарные данные»:</p>
  <ol>
    <li>Добавьте новый документ «Бинарные данные» через меню «Добавить документ»</li>
    <li>На вкладке «Тело документа» загрузите файл</li>
  </ol>
  <img src="https://edata.customs.ru/FtsPersonalCabinetWeb2017/Service/GetFile?src=Binary.gif" alt="Добавление файла в архив" style="max-width:100%;">
</div>', 
'html'),

('lk', 'Не могу войти в Личный кабинет по логину и паролю. Что делать?', 
'<div class="answer-content">
  <p>Возможные причины:</p>
  <ul>
    <li>Не завершена регистрация (проверьте email с подтверждением)</li>
    <li>Неправильная раскладка клавиатуры или CapsLock</li>
    <li>Пароль устарел</li>
  </ul>
  <p>Для восстановления пароля: <a href="https://edata.customs.ru/FtsPersonalCabinetWeb2017/Help/#?topic=Password_email&src=Help" target="_blank">инструкция по смене пароля</a></p>
</div>', 
'html'),

('customs-procedures', 'Как отправить изменения в ДТ после выпуска товара?', 
'<div class="answer-content">
  <p>Подробная инструкция: <a href="https://edata.customs.ru/FtsPersonalCabinetWeb2017/Help/#?topic=Ed_KDT_after&src=Help" target="_blank">Внесение изменений в ДТ после выпуска</a></p>
  <p class="warning">Важно! Используйте правильную кнопку для изменений:</p>
  <img src="https://edata.customs.ru/FtsPersonalCabinetWeb2017/Service/GetFile?src=blobid1557154800252.jpg" alt="Кнопка для изменений" style="max-width:100%;">
</div>', 
'html');