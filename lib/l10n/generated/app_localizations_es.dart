// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Student Housing';

  @override
  String get commonRetry => 'Reintentar';

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonClear => 'Limpiar';

  @override
  String get commonOk => 'Aceptar';

  @override
  String get commonOr => 'o';

  @override
  String get commonNotSet => 'Sin definir';

  @override
  String get commonUnknown => 'Desconocido';

  @override
  String get navHome => 'Inicio';

  @override
  String get navChat => 'Chat';

  @override
  String get navSearch => 'Buscar';

  @override
  String get navBookings => 'Reservas';

  @override
  String get navProfile => 'Perfil';

  @override
  String get authWelcomeBackTitle => 'Bienvenido de nuevo';

  @override
  String get authWelcomeBackSubtitle =>
      'Inicia sesión para encontrar tu próximo hogar estudiantil.';

  @override
  String get authEmailLabel => 'Correo electrónico';

  @override
  String get authEmailHint => 'tu@ejemplo.com';

  @override
  String get authPasswordLabel => 'Contraseña';

  @override
  String get authLoginButton => 'Iniciar sesión';

  @override
  String get authNoAccountQuestion => '¿No tienes una cuenta?';

  @override
  String get authRegisterButton => 'Registrarse';

  @override
  String get authCreateAccountTitle => 'Crear cuenta';

  @override
  String get authRegisterSubtitle =>
      'Únete como estudiante para explorar y reservar habitaciones.';

  @override
  String get authFirstNameLabel => 'Nombre';

  @override
  String get authLastNameLabel => 'Apellido';

  @override
  String get authPhoneLabel => 'Número de teléfono';

  @override
  String get authNationalityLabel => 'Nacionalidad';

  @override
  String get authGenderLabel => 'Género';

  @override
  String get authGenderMale => 'Masculino';

  @override
  String get authGenderFemale => 'Femenino';

  @override
  String get authGenderOther => 'Otro';

  @override
  String get authSelectGender => 'Selecciona tu género';

  @override
  String get authBirthDateLabel => 'Fecha de nacimiento';

  @override
  String get authBirthDateHint => 'aaaa-mm-dd';

  @override
  String get authSelectBirthDate => 'Selecciona tu fecha de nacimiento';

  @override
  String get authConfirmPasswordLabel => 'Confirmar contraseña';

  @override
  String get authPasswordsDoNotMatch => 'Las contraseñas no coinciden';

  @override
  String get authCreateAccountButton => 'Crear cuenta';

  @override
  String get authAlreadyHaveAccount => '¿Ya tienes una cuenta?';

  @override
  String get authContinueWithGoogle => 'Continuar con Google';

  @override
  String get authAccountCreatedTitle => 'Cuenta creada';

  @override
  String get authAccountCreatedBody =>
      'Revisa tu correo para confirmar tu cuenta y luego inicia sesión.';

  @override
  String get authValidatorEmailRequired => 'Ingresa tu correo electrónico';

  @override
  String get authValidatorEmailInvalid => 'Ingresa un correo válido';

  @override
  String get authValidatorFirstNameRequired => 'Ingresa tu nombre';

  @override
  String get authValidatorLastNameRequired => 'Ingresa tu apellido';

  @override
  String get authValidatorNationalityRequired => 'Ingresa tu nacionalidad';

  @override
  String get authValidatorPhoneRequired => 'Ingresa tu número de teléfono';

  @override
  String get authValidatorPhoneInvalid => 'Usa entre 7 y 15 dígitos';

  @override
  String get authValidatorPasswordRequired => 'Ingresa una contraseña';

  @override
  String get authValidatorPasswordMinLength => 'Al menos 8 caracteres';

  @override
  String get authValidatorPasswordUppercase => 'Agrega una letra mayúscula';

  @override
  String get authValidatorPasswordLowercase => 'Agrega una letra minúscula';

  @override
  String get authValidatorPasswordNumber => 'Agrega un número';

  @override
  String get authValidatorPasswordSpecial => 'Agrega un carácter especial';

  @override
  String get authValidatorLoginPasswordRequired => 'Ingresa tu contraseña';

  @override
  String get homeWelcome => '¡Bienvenido, estudiante!';

  @override
  String get homeSubtitle => 'Encuentra tu próxima habitación rápidamente.';

  @override
  String get homeSearchHint => 'Busca habitaciones por nombre';

  @override
  String get homeFeaturedRooms => 'Habitaciones destacadas';

  @override
  String get homeShowMore => 'Ver más';

  @override
  String get homeNoRooms => 'No hay habitaciones disponibles en este momento.';

  @override
  String get searchTitle => 'Encuentra una habitación';

  @override
  String get searchMinPrice => 'Precio mín.';

  @override
  String get searchMaxPrice => 'Precio máx.';

  @override
  String get searchMaxPriceHintAny => 'Cualquiera';

  @override
  String get servicesTitle => 'Servicios';

  @override
  String get searchButton => 'Buscar';

  @override
  String get searchNoResults => 'Ninguna habitación coincide con tus filtros.';

  @override
  String searchResultsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count habitaciones encontradas',
      one: '1 habitación encontrada',
    );
    return '$_temp0';
  }

  @override
  String get sortByLabel => 'Ordenar por';

  @override
  String get sortPriceAsc => 'Precio (menor a mayor)';

  @override
  String get sortPriceDesc => 'Precio (mayor a menor)';

  @override
  String get sortNameAsc => 'Nombre (A–Z)';

  @override
  String get sortNameDesc => 'Nombre (Z–A)';

  @override
  String get serviceWifi => 'WiFi';

  @override
  String get serviceKitchen => 'Cocina';

  @override
  String get serviceTv => 'TV';

  @override
  String get serviceAirConditioner => 'Aire acondicionado';

  @override
  String get serviceGymEquipment => 'Equipo de gimnasio';

  @override
  String get roomStatusAvailable => 'Disponible';

  @override
  String get roomStatusBooked => 'Reservada';

  @override
  String get roomStatusUnavailable => 'No disponible';

  @override
  String get detailsPerMonth => '/ mes';

  @override
  String get detailsDescription => 'Descripción';

  @override
  String get detailsNoDescription => 'No se proporcionó descripción.';

  @override
  String get detailsLocation => 'Ubicación';

  @override
  String get detailsNoServices => 'No hay servicios listados.';

  @override
  String get detailsPolicies => 'Políticas';

  @override
  String get detailsNoPolicies => 'No hay políticas listadas.';

  @override
  String get detailsOwner => 'Propietario';

  @override
  String get detailsBookRoom => 'Reservar habitación';

  @override
  String get detailsBookingUnavailable => 'Reserva no disponible';

  @override
  String get detailsCancelRequest => 'Cancelar solicitud';

  @override
  String get detailsChatButton => 'Chat';

  @override
  String get detailsShareButton => 'Compartir';

  @override
  String detailsShareMessage(String roomName, String url) {
    return 'Mira \"$roomName\" en Student Lib: $url';
  }

  @override
  String get detailsBookingSuccessTitle => 'Habitación reservada';

  @override
  String get detailsBookingSuccess => 'Reserva realizada con éxito.';

  @override
  String get detailsRequestCancelled => 'Solicitud cancelada.';

  @override
  String get chatsTitle => 'Chats';

  @override
  String get chatEmpty =>
      'Aún no hay chats.\nInicia uno desde una habitación para contactar a su propietario.';

  @override
  String get chatThreadTitle => 'Chat';

  @override
  String get chatReconnecting => 'Reconectando…';

  @override
  String get chatMessageHint => 'Mensaje…';

  @override
  String get chatNoMessages => 'Aún no hay mensajes.\n¡Saluda!';

  @override
  String get chatCouldNotStart => 'No se pudo iniciar el chat.';

  @override
  String get chatYesterday => 'Ayer';

  @override
  String get chatWeekdayMon => 'Lun';

  @override
  String get chatWeekdayTue => 'Mar';

  @override
  String get chatWeekdayWed => 'Mié';

  @override
  String get chatWeekdayThu => 'Jue';

  @override
  String get chatWeekdayFri => 'Vie';

  @override
  String get chatWeekdaySat => 'Sáb';

  @override
  String get chatWeekdaySun => 'Dom';

  @override
  String get bookingsTitle => 'Mis reservas';

  @override
  String get bookingsEmpty => 'Aún no tienes reservas.';

  @override
  String get bookingStatusPending => 'Pendiente';

  @override
  String get bookingStatusApproved => 'Aprobada';

  @override
  String get bookingStatusRejected => 'Rechazada';

  @override
  String get profileTitle => 'Perfil';

  @override
  String get profileYourProfile => 'Tu perfil';

  @override
  String get profileBirthdateLabel => 'Fecha de nacimiento';

  @override
  String get profileEditButton => 'Editar perfil';

  @override
  String get profileLogout => 'Cerrar sesión';

  @override
  String get profileLanguageLabel => 'Idioma';

  @override
  String get profileSelectNationality => 'Selecciona tu nacionalidad';

  @override
  String get profileSaveChanges => 'Guardar cambios';

  @override
  String get profileFirstNameRequired => 'El nombre es obligatorio.';

  @override
  String get profileUpdated => 'Perfil actualizado.';

  @override
  String get profileChangePhoto => 'Cambiar foto';

  @override
  String get profileTakePhoto => 'Tomar foto';

  @override
  String get profileChooseGallery => 'Elegir de la galería';

  @override
  String get profilePhotoPreviewTitle => '¿Usar esta foto?';

  @override
  String get profilePhotoConfirm => 'Usar foto';

  @override
  String get profilePhotoUpdated => 'Foto de perfil actualizada.';

  @override
  String get profilePhotoError => 'No se pudo actualizar tu foto de perfil.';
}
