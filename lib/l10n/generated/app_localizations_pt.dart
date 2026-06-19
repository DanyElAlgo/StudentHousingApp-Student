// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Student Housing';

  @override
  String get commonRetry => 'Tentar novamente';

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonClear => 'Limpar';

  @override
  String get commonOk => 'OK';

  @override
  String get commonOr => 'ou';

  @override
  String get commonNotSet => 'Não definido';

  @override
  String get commonUnknown => 'Desconhecido';

  @override
  String get navHome => 'Início';

  @override
  String get navChat => 'Chat';

  @override
  String get navSearch => 'Buscar';

  @override
  String get navBookings => 'Reservas';

  @override
  String get navProfile => 'Perfil';

  @override
  String get authWelcomeBackTitle => 'Bem-vindo de volta';

  @override
  String get authWelcomeBackSubtitle =>
      'Faça login para encontrar sua próxima moradia estudantil.';

  @override
  String get authEmailLabel => 'E-mail';

  @override
  String get authEmailHint => 'voce@exemplo.com';

  @override
  String get authPasswordLabel => 'Senha';

  @override
  String get authLoginButton => 'Entrar';

  @override
  String get authNoAccountQuestion => 'Não tem uma conta?';

  @override
  String get authRegisterButton => 'Cadastrar-se';

  @override
  String get authCreateAccountTitle => 'Criar conta';

  @override
  String get authRegisterSubtitle =>
      'Cadastre-se como estudante para explorar e reservar quartos.';

  @override
  String get authFirstNameLabel => 'Nome';

  @override
  String get authLastNameLabel => 'Sobrenome';

  @override
  String get authPhoneLabel => 'Número de telefone';

  @override
  String get authNationalityLabel => 'Nacionalidade';

  @override
  String get authGenderLabel => 'Gênero';

  @override
  String get authGenderMale => 'Masculino';

  @override
  String get authGenderFemale => 'Feminino';

  @override
  String get authGenderOther => 'Outro';

  @override
  String get authSelectGender => 'Selecione seu gênero';

  @override
  String get authBirthDateLabel => 'Data de nascimento';

  @override
  String get authBirthDateHint => 'aaaa-mm-dd';

  @override
  String get authSelectBirthDate => 'Selecione sua data de nascimento';

  @override
  String get authConfirmPasswordLabel => 'Confirmar senha';

  @override
  String get authPasswordsDoNotMatch => 'As senhas não coincidem';

  @override
  String get authCreateAccountButton => 'Criar conta';

  @override
  String get authAlreadyHaveAccount => 'Já tem uma conta?';

  @override
  String get authContinueWithGoogle => 'Continuar com o Google';

  @override
  String get authAccountCreatedTitle => 'Conta criada';

  @override
  String get authAccountCreatedBody =>
      'Verifique seu e-mail para confirmar sua conta e depois faça login.';

  @override
  String get authValidatorEmailRequired => 'Informe seu e-mail';

  @override
  String get authValidatorEmailInvalid => 'Informe um e-mail válido';

  @override
  String get authValidatorFirstNameRequired => 'Informe seu nome';

  @override
  String get authValidatorLastNameRequired => 'Informe seu sobrenome';

  @override
  String get authValidatorNationalityRequired => 'Informe sua nacionalidade';

  @override
  String get authValidatorPhoneRequired => 'Informe seu número de telefone';

  @override
  String get authValidatorPhoneInvalid => 'Use de 7 a 15 dígitos';

  @override
  String get authValidatorPasswordRequired => 'Informe uma senha';

  @override
  String get authValidatorPasswordMinLength => 'Pelo menos 8 caracteres';

  @override
  String get authValidatorPasswordUppercase => 'Adicione uma letra maiúscula';

  @override
  String get authValidatorPasswordLowercase => 'Adicione uma letra minúscula';

  @override
  String get authValidatorPasswordNumber => 'Adicione um número';

  @override
  String get authValidatorPasswordSpecial => 'Adicione um caractere especial';

  @override
  String get authValidatorLoginPasswordRequired => 'Informe sua senha';

  @override
  String get homeWelcome => 'Bem-vindo, estudante!';

  @override
  String get homeSubtitle => 'Encontre seu próximo quarto rapidamente.';

  @override
  String get homeSearchHint => 'Pesquise quartos por nome';

  @override
  String get homeFeaturedRooms => 'Quartos em destaque';

  @override
  String get homeShowMore => 'Ver mais';

  @override
  String get homeNoRooms => 'Nenhum quarto disponível no momento.';

  @override
  String get searchTitle => 'Encontre um quarto';

  @override
  String get searchMinPrice => 'Preço mín.';

  @override
  String get searchMaxPrice => 'Preço máx.';

  @override
  String get searchMaxPriceHintAny => 'Qualquer';

  @override
  String get servicesTitle => 'Serviços';

  @override
  String get searchButton => 'Buscar';

  @override
  String get searchNoResults => 'Nenhum quarto corresponde aos seus filtros.';

  @override
  String searchResultsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count quartos encontrados',
      one: '1 quarto encontrado',
    );
    return '$_temp0';
  }

  @override
  String get sortByLabel => 'Ordenar por';

  @override
  String get sortPriceAsc => 'Preço (menor para maior)';

  @override
  String get sortPriceDesc => 'Preço (maior para menor)';

  @override
  String get sortNameAsc => 'Nome (A–Z)';

  @override
  String get sortNameDesc => 'Nome (Z–A)';

  @override
  String get serviceWifi => 'WiFi';

  @override
  String get serviceKitchen => 'Cozinha';

  @override
  String get serviceTv => 'TV';

  @override
  String get serviceAirConditioner => 'Ar-condicionado';

  @override
  String get serviceGymEquipment => 'Equipamento de ginástica';

  @override
  String get roomStatusAvailable => 'Disponível';

  @override
  String get roomStatusBooked => 'Reservado';

  @override
  String get roomStatusUnavailable => 'Indisponível';

  @override
  String get detailsPerMonth => '/ mês';

  @override
  String get detailsDescription => 'Descrição';

  @override
  String get detailsNoDescription => 'Nenhuma descrição fornecida.';

  @override
  String get detailsLocation => 'Localização';

  @override
  String get detailsNoServices => 'Nenhum serviço listado.';

  @override
  String get detailsPolicies => 'Políticas';

  @override
  String get detailsNoPolicies => 'Nenhuma política listada.';

  @override
  String get detailsOwner => 'Proprietário';

  @override
  String get detailsBookRoom => 'Reservar quarto';

  @override
  String get detailsBookingUnavailable => 'Reserva indisponível';

  @override
  String get detailsCancelRequest => 'Cancelar solicitação';

  @override
  String get detailsChatButton => 'Chat';

  @override
  String get detailsShareButton => 'Compartilhar';

  @override
  String detailsShareMessage(String roomName, String url) {
    return 'Confira \"$roomName\" no Student Lib: $url';
  }

  @override
  String get detailsBookingSuccessTitle => 'Quarto reservado';

  @override
  String get detailsBookingSuccess => 'Reserva realizada com sucesso.';

  @override
  String get detailsRequestCancelled => 'Solicitação cancelada.';

  @override
  String get chatsTitle => 'Conversas';

  @override
  String get chatEmpty =>
      'Nenhuma conversa ainda.\nInicie uma a partir de um quarto para contatar o proprietário.';

  @override
  String get chatThreadTitle => 'Chat';

  @override
  String get chatReconnecting => 'Reconectando…';

  @override
  String get chatMessageHint => 'Mensagem…';

  @override
  String get chatNoMessages => 'Nenhuma mensagem ainda.\nDiga olá!';

  @override
  String get chatCouldNotStart => 'Não foi possível iniciar a conversa.';

  @override
  String get chatYesterday => 'Ontem';

  @override
  String get chatWeekdayMon => 'Seg';

  @override
  String get chatWeekdayTue => 'Ter';

  @override
  String get chatWeekdayWed => 'Qua';

  @override
  String get chatWeekdayThu => 'Qui';

  @override
  String get chatWeekdayFri => 'Sex';

  @override
  String get chatWeekdaySat => 'Sáb';

  @override
  String get chatWeekdaySun => 'Dom';

  @override
  String get bookingsTitle => 'Minhas reservas';

  @override
  String get bookingsEmpty => 'Você ainda não tem reservas.';

  @override
  String get bookingStatusPending => 'Pendente';

  @override
  String get bookingStatusApproved => 'Aprovada';

  @override
  String get bookingStatusRejected => 'Rejeitada';

  @override
  String get profileTitle => 'Perfil';

  @override
  String get profileYourProfile => 'Seu perfil';

  @override
  String get profileBirthdateLabel => 'Data de nascimento';

  @override
  String get profileEditButton => 'Editar perfil';

  @override
  String get profileLogout => 'Sair';

  @override
  String get profileLanguageLabel => 'Idioma';

  @override
  String get profileSelectNationality => 'Selecione sua nacionalidade';

  @override
  String get profileSaveChanges => 'Salvar alterações';

  @override
  String get profileFirstNameRequired => 'O nome é obrigatório.';

  @override
  String get profileUpdated => 'Perfil atualizado.';
}
