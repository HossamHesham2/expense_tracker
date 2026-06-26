// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:google_sign_in/google_sign_in.dart' as _i116;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/add_transactions/data/repository/add_transaction_repo_impl.dart'
    as _i709;
import '../../features/add_transactions/data/request/add_transaction_remote.dart'
    as _i42;
import '../../features/add_transactions/data/request/add_transaction_remote_impl.dart'
    as _i639;
import '../../features/add_transactions/domain/repository/add_transaction_repo.dart'
    as _i140;
import '../../features/add_transactions/domain/usecases/add_transaction_use_case.dart'
    as _i273;
import '../../features/auth/data/repository/auth_repo_impl.dart' as _i751;
import '../../features/auth/data/request/remote/auth_remote.dart' as _i68;
import '../../features/auth/data/request/remote/auth_remote_impl.dart' as _i188;
import '../../features/auth/domain/repository/auth_repo.dart' as _i976;
import '../../features/auth/domain/usecases/login_use_case.dart' as _i37;
import '../../features/auth/domain/usecases/login_with_google_use_case.dart'
    as _i151;
import '../../features/auth/domain/usecases/register_use_case.dart' as _i97;
import '../../features/auth/presentation/bloc/auth_bloc.dart' as _i797;
import '../../features/home/data/repository/auth_repository_impl.dart' as _i442;
import '../../features/home/data/request/remote/auth_remote.dart' as _i238;
import '../../features/home/data/request/remote/auth_remote_impl.dart' as _i645;
import '../../features/home/domain/repository/auth_repository.dart' as _i533;
import 'firebase_module.dart' as _i616;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final firebaseModule = _$FirebaseModule();
    gh.lazySingleton<_i59.FirebaseAuth>(() => firebaseModule.firebaseAuth);
    gh.lazySingleton<_i974.FirebaseFirestore>(
      () => firebaseModule.firebaseFirestore,
    );
    gh.factory<_i140.AddTransactionRepo>(() => _i709.AddTransactionRepoImpl());
    gh.factory<_i42.AddTransactionRemote>(
      () => _i639.AddTransactionRemoteImpl(),
    );
    gh.factory<_i533.AuthRepository>(() => _i442.AuthRepositoryImpl());
    gh.factory<_i273.AddTransactionUseCase>(
      () => _i273.AddTransactionUseCase(
        addTransactionRepo: gh<_i140.AddTransactionRepo>(),
      ),
    );
    gh.factory<_i68.AuthRemote>(
      () => _i188.AuthRemoteImpl(
        firebaseAuth: gh<_i59.FirebaseAuth>(),
        firebaseFirestore: gh<_i974.FirebaseFirestore>(),
      ),
    );
    gh.factory<_i238.AuthRemote>(
      () => _i645.AuthRemoteImpl(
        firebaseAuth: gh<_i59.FirebaseAuth>(),
        firebaseFirestore: gh<_i974.FirebaseFirestore>(),
        googleSignIn: gh<_i116.GoogleSignIn>(),
      ),
    );
    gh.factory<_i976.AuthRepo>(
      () => _i751.AuthRepoImpl(authRemote: gh<_i68.AuthRemote>()),
    );
    gh.factory<_i37.LoginUseCase>(
      () => _i37.LoginUseCase(authRepo: gh<_i976.AuthRepo>()),
    );
    gh.factory<_i151.LoginWithGoogleUseCase>(
      () => _i151.LoginWithGoogleUseCase(authRepo: gh<_i976.AuthRepo>()),
    );
    gh.factory<_i97.RegisterUseCase>(
      () => _i97.RegisterUseCase(authRepo: gh<_i976.AuthRepo>()),
    );
    gh.factory<_i797.AuthBloc>(
      () => _i797.AuthBloc(
        loginUseCase: gh<_i37.LoginUseCase>(),
        loginWithGoogleUseCase: gh<_i151.LoginWithGoogleUseCase>(),
        registerUseCase: gh<_i97.RegisterUseCase>(),
      ),
    );
    return this;
  }
}

class _$FirebaseModule extends _i616.FirebaseModule {}
