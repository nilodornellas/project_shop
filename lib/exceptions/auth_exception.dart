class AuthException implements Exception {
  final String key;
  AuthException(this.key);

  static const Map<String, String> _erros = {
    'EMAIL_EXISTS': 'E-mail já cadastrado.',
    'OPERATION_NOT_ALLOWED': 'Operação não permitida.',
    'TOO_MANY_ATTEMPTS_TRY_LATER':
        'Acesso bloqueado temporariamente. Tente mais tarde',
    'EMAIL_NOT_FOUND': 'E-mail não encontrado.',
    'INVALID_PASSWORD': 'Senha informada não confere.',
    'USER_DISABLED': 'A conta do usuário foi desabilitada.',
  };

  @override
  String toString() {
    return _erros[key] ?? 'Ocorreu um erro no processo de autenticação.';
  }
}
