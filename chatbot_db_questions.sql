-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: chatbot_db
-- ------------------------------------------------------
-- Server version	8.0.42

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `questions`
--

DROP TABLE IF EXISTS `questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `questions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `section_id` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `question` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `answer` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_type` enum('text','html') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'html',
  PRIMARY KEY (`id`),
  KEY `section_id_idx` (`section_id`),
  CONSTRAINT `fk_section` FOREIGN KEY (`section_id`) REFERENCES `sections` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questions`
--

LOCK TABLES `questions` WRITE;
/*!40000 ALTER TABLE `questions` DISABLE KEYS */;
INSERT INTO `questions` VALUES (1,'signature','Нужна ли мне ЭП или достаточно войти в ЛК через Госуслуги?','<div class=\"answer-content\">\n  <p>Начнем с того, что большинство сервисов Личного кабинета (ЛК) предназначены для юридических лиц (ЮЛ) и индивидуальных предпринимателей (ИП) (далее про ЮЛ и ИП говорим - организации).</p>\n  <p>Для кого предназначен сервис и нужна ли для него ЭП, см. в разделе Справки <a href=\"https://edata.customs.ru/FtsPersonalCabinetWeb2017/Help/#?topic=Nuzhna_EP&src=Help\" target=\"_blank\">Определите, требуется ли вам для работы электронная подпись</a>.</p>\n  <p>Для работы с сервисами для организаций - в вашем ЛК обязательно должна быть подтверждена организация.</p>\n  <img src=\"https://edata.customs.ru/FtsPersonalCabinetWeb2017/Service/GetFile?src=ep_confirmation.png\" alt=\"Подтверждение организации\" style=\"max-width:100%;\">\n</div>','html'),(2,'signature','Не устанавливается/не работает плагин для работы с ЭП','<div class=\"answer-content\">\n  <p>Если вы установили плагин Крипто-Про ЭЦП Browser Plug-in, но всё равно на сайте появляется сообщение с предложением его установки, выполните следующую последовательность действий:</p>\n  <ol>\n    <li>Перед новой установкой удалите плагин(ы), который вы устанавливали в прежних попытках через <strong>Панель управления → Программы и компоненты</strong></li>\n    <li>Почистите кэш браузера</li>\n    <li>Скачайте и запустите плагин заново под правами администратора</li>\n    <li>Перезагрузите компьютер сразу после установки</li>\n  </ol>\n  <p>Если проблема сохраняется, обратитесь в <a href=\"https://cryptopro.ru/support\" target=\"_blank\">техническую поддержку КриптоПро</a>.</p>\n</div>','html'),(3,'account','Как открыть лицевой счёт?','<div class=\"answer-content\">\n  <p>ЛС открывается автоматически при перечислении денежных средств в таможенные органы.</p>\n  <p>Платежи по ЛС вносятся на счет таможенного органа по коду «10000010» (поле 107 п/п).</p>\n  <p><a href=\"https://customs.gov.ru/uchastnikam-ved/uplata-tamozhennyx-i-inyx-platezhej/rekvizity-scheta-dlya-perechisleniy\" target=\"_blank\">Реквизиты счета для оплаты таможенных платежей.</a></p>\n  <p>Порядок открытия единого лицевого счета отражен в приказе ФТС России от 29.04.2019 № 727</p>\n</div>','html'),(4,'account','Как выгрузить Подтверждение уплаты таможенных пошлин, налогов и Отчет о расходовании денежных средств, внесенных в качестве авансовых платежей в Excel?','<div class=\"answer-content\">\n  <p>Откройте на просмотр полученный от ТО ответ. Нажмите кнопку Печать, после этого в открывшемся окне будет доступна кнопка XLS.</p>\n  <p class=\"note\">К сведению! В Excel выгружается только табличная часть!</p>\n  <img src=\"https://edata.customs.ru/FtsPersonalCabinetWeb2017/Service/GetFile?src=blobid1557231420799.gif\" alt=\"Процесс выгрузки в Excel\" style=\"max-width:100%;\">\n</div>','html'),(5,'pre-info','Как подать ПИ в объём ДТ?','<div class=\"answer-content\">\n  <p>В случае предварительного декларирования в ПИ указываются:</p>\n  <ul>\n    <li>все обязательные поля, помеченные красной звёздочкой</li>\n    <li>рег.номер ПТД на вкладке Сведения о товарной партии</li>\n  </ul>\n  <img src=\"https://edata.customs.ru/FtsPersonalCabinetWeb2017/Service/GetFile?src=01.png\" alt=\"Подача ПИ в объём ДТ\" style=\"max-width:100%;\">\n</div>','html'),(6,'archive','Как добавить изображение или файл pdf в архив?','<div class=\"answer-content\">\n  <p>Изображение добавляется в Электронный архив в виде документа «Бинарные данные»:</p>\n  <ol>\n    <li>Добавьте новый документ «Бинарные данные» через меню «Добавить документ»</li>\n    <li>На вкладке «Тело документа» загрузите файл</li>\n  </ol>\n  <img src=\"https://edata.customs.ru/FtsPersonalCabinetWeb2017/Service/GetFile?src=Binary.gif\" alt=\"Добавление файла в архив\" style=\"max-width:100%;\">\n</div>','html'),(7,'lk','Не могу войти в Личный кабинет по логину и паролю. Что делать?','<div class=\"answer-content\">\n  <p>Возможные причины:</p>\n  <ul>\n    <li>Не завершена регистрация (проверьте email с подтверждением)</li>\n    <li>Неправильная раскладка клавиатуры или CapsLock</li>\n    <li>Пароль устарел</li>\n  </ul>\n  <p>Для восстановления пароля: <a href=\"https://edata.customs.ru/FtsPersonalCabinetWeb2017/Help/#?topic=Password_email&src=Help\" target=\"_blank\">инструкция по смене пароля</a></p>\n</div>','html'),(8,'customs-procedures','Как отправить изменения в ДТ после выпуска товара?','<div class=\"answer-content\">\n  <p>Подробная инструкция: <a href=\"https://edata.customs.ru/FtsPersonalCabinetWeb2017/Help/#?topic=Ed_KDT_after&src=Help\" target=\"_blank\">Внесение изменений в ДТ после выпуска</a></p>\n  <p class=\"warning\">Важно! Используйте правильную кнопку для изменений:</p>\n  <img src=\"https://edata.customs.ru/FtsPersonalCabinetWeb2017/Service/GetFile?src=blobid1557154800252.jpg\" alt=\"Кнопка для изменений\" style=\"max-width:100%;\">\n</div>','html');
/*!40000 ALTER TABLE `questions` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-17 18:03:39
