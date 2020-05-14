import 'package:i18n_extension/i18n_extension.dart';

/// extension for the String class to include the function "".i18n to translate the string
extension Localization on String {
  static var _t = Translations("en_us") +
      {
        "en_us": "Task Manager",
        "pt_br": "Task Manager",
      } +
      {
        "en_us": "Task Dialog",
        "pt_br": "Task Dialog",
      } +
      {
        "en_us": "What is the title?",
        "pt_br": "Qual é o titulo?",
      } +
      {
        "en_us": "Title *",
        "pt_br": "titulo *",
      } +
      {
        "en_us": "Repeat",
        "pt_br": "Repete",
      } +
      {
        "en_us": "Frequency",
        "pt_br": "Frequencia",
      } +
      {
        "en_us": "Use Location",
        "pt_br": "Usa Localização",
      } +
      {
        "en_us": "What is the task description?",
        "pt_br": "Qual é a descrição?",
      } +
      {
        "en_us": "Description",
        "pt_br": "Descrição",
      } +
      {
        "en_us": "Add Task",
        "pt_br": "Adicionar Tarefa",
      } +
      {
        "en_us": "Title must not be empty",
        "pt_br": "Titulo não deve ser vazio",
      } +
      {
        "en_us": "Cancel",
        "pt_br": "Cancelar",
      } +
      {
        "en_us": "Accept",
        "pt_br": "Aceitar",
      } +
      {
        "en_us": "Settings",
        "pt_br": "Configurações",
      } +
      {
        "en_us": "Delete Task ",
        "pt_br": "Deletar Tarefa",
      } +
      {
        "en_us": "Are you sure you want to delete the task ",
        "pt_br": "Você tem certeza que deseja deletar a tarefa ",
      } +
      {
        "en_us": "Set Location",
        "pt_br": "Configurar Localização",
      } +
      {
        "en_us": "Language",
        "pt_br": "Idioma",
      } +
      {
        "en_us": "Current language:",
        "pt_br": "Idioma Atual: ",
      } +
      {
        "en_us": "Portuguese",
        "pt_br": "Portugues",
      } +
      {
        "en_us": "English",
        "pt_br": "Ingles  ",
      };

  String get i18n => localize(this, _t);
}
