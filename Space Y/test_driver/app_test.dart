import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Inscription & Connexion', () {
    // Boutons
    final SerializableFinder kSignUpButton =  find.byValueKey('fromStartupPageGoToSignUp');
    final SerializableFinder kLogoutButton = find.byValueKey('LogoutButton');
    final SerializableFinder kLoginSubmitButton = find.byValueKey('loginSubmitButton');

    // TextFields
    final SerializableFinder kUsernameTextField = find.byValueKey('UsernameTextField');
    final SerializableFinder kEmailTextField = find.byValueKey('EmailTextField');
    final SerializableFinder kPasswordTextField = find.byValueKey('PasswordTextField');
    final SerializableFinder kSignUpSubmitButton = find.byValueKey('SignUpSubmitButton');
    final SerializableFinder kLoginEmailTextField = find.byValueKey('LoginEmailTextField');
    final SerializableFinder kLoginPasswordTextField = find.byValueKey('LoginPasswordTextField');

    // Scrollable
    final SerializableFinder kScrollableStartupPage = find.byValueKey('StartupScrollablePage');
    final SerializableFinder kSignUpScrollableContainer = find.byValueKey('SignUpScrollableContainer');
    final SerializableFinder kLoginScrollableColumn = find.byValueKey('loginScrollableColumn');
    final SerializableFinder kProfileScrollable = find.byValueKey('ProfileScrollable');

    // Valeurs test
    const String kUsername = 'KsumNole';
    const String kEmail = 'KsumNole@spaceY.com';
    const String kPassword = 'azertyuiopqsdfghj';

    FlutterDriver driver;
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      driver.close();
    });

    test("Inscription Depuis l'écran d'accueil suivi d'une déconnexion", () async {
      // Clique sur le bouton d'inscription
      await driver.tap(kSignUpButton);

      // Remplis tous les champs
      await driver.tap(kUsernameTextField);
      await driver.enterText(kUsername);

      await driver.tap(kEmailTextField);
      await driver.enterText(kEmail);

      await driver.tap(kPasswordTextField);
      await driver.enterText(kPassword);

      // Scroll en bas de la page (pour les petits écrans) et appuie sur le bouton d'inscription
      await driver.scrollUntilVisible(
          kSignUpScrollableContainer,
          kSignUpSubmitButton,
          dyScroll: -3000);
      await driver.tap(kSignUpSubmitButton);

      await driver.tap(find.text('Profile'));

      // Scroll sur le bouton de logout
      await driver.scrollUntilVisible(
          kProfileScrollable,
          kLogoutButton,
          dyScroll: -3000);


      // Clique sur le bouton de logout
      await driver.tap(kLogoutButton);
    });

    test("Connexion depuis l'écran d'accueil", () async {
      await driver.scrollUntilVisible(
          kScrollableStartupPage,
          kLoginEmailTextField,
        dxScroll: 3000
      );

      await driver.tap(kLoginEmailTextField);
      await driver.enterText(kEmail);

      await driver.tap(kLoginPasswordTextField);
      await driver.enterText(kPassword);

      await driver.scrollUntilVisible(
          kLoginScrollableColumn,
          kLoginSubmitButton,
          dyScroll: -3000
      );

      await driver.tap(kLoginSubmitButton);
    });
  });
}