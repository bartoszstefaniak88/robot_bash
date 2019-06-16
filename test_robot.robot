*** Settings ***
Library    SSHLibrary
Library    jakchcecie.py
Library    SeleniumLibrary
Library    OperatingSystem

*** Variables ***
${WIADOMOSC}    Wszystko jest OK !
${ADRES_HOST}   localhost
${USER}     tester
${HASLO}    tester
${BROWSER}   Firefox
${URL}    https://www.wp.pl/
${POCZTA_URL}     https://profil.wp.pl/login.html?zaloguj=poczta
${LOGIN}   testerwsb_t1
${HASLO_WP}     adam1234
${XPATH_LOGIN}     //*[@id="login"]
${XPATH_HASLO}      //*[@id="password"]
${ZALOGUJ_BUTTON}     //*[@id="btnSubmit"]
${ZALOGOWANY_URL}       https://poczta.wp.pl/k/#/mails/?label=1

*** Test Cases ***
My Test
   Log to console    dzien dobry
Moj drugi test
   Keyword dzien dobry swiecie      moj tekscik
Moj trzeci Test
   Log to console    ${WIADOMOSC}

Moj test polaczenia ssh
   Nawiazanie polaczenia z localhost
   Podanie hasla do autoryzacji
   sprawdzenie poprawnosci zalogowania
   wylogowanie

Moj test polaczenia z internetem
   Nawiazanie polaczenia z localhost
   Podanie hasla do autoryzacji
   sprawdzenie poprawnosci polaczenia z internetem
  wylogowanie

Moj test sprawdzenie liczby procesorow
   Nawiazanie polaczenia z localhost
   Podanie hasla do autoryzacji
   sprawdzenie ilosci procesorow
   wylogowanie

Test jakchcecie
      Sprawdzenie jakchcecie

Test Logowanie do poczty
    Otwarcie strony
    Przejscie do poczta
    Wpisz Login
    Wpisz Haslo
    Sleep    2
    Zaloguj klik
    Sleep    3
    Sprawdzenie zalogowania
    Zdjecie zalogowany
    Sleep    1
    zamkniecie przegladarki
Podanie IP
    Uruchomienie skryptu

*** Keywords ***
Keyword dzien dobry swiecie
      [Arguments]    ${mojazmienna}
      Log to console    ${mojazmienna}

Nawiazanie polaczenia z localhost
     Open Connection     ${ADRES_HOST}

Podanie hasla do autoryzacji
     Login     ${USER}     ${HASLO}

sprawdzenie poprawnosci zalogowania
    ${sprawdzenie}=         Execute Command    uname -a
    Should Contain    ${sprawdzenie}    UTC 2019 x86_64 x86_64 x86_64 GNU/Linux

sprawdzenie poprawnosci polaczenia z internetem
      ${sprawdzenie_internet}=         Execute Command    ping -c1 wp.pl
      Should Contain    ${sprawdzenie_internet}     bytes from www.wp.pl (212.77.98.9)

sprawdzenie ilosci procesorow
      ${sprawdzenie_cpu}=         Execute Command    cat /proc/cpuinfo | grep "cpu cores" | cut -c13-
      Log To Console     ${sprawdzenie_cpu}
      Should Contain     ${sprawdzenie_cpu}     1

Sprawdzenie jakchcecie
      ${sprawdzenie_jakchcecie}    witaj
      Should Be Equal    ${sprawdzenie_jakchcecie}    Hello world

Otwarcie strony
      Open browser     ${URL}        ${BROWSER}

Przejscie do poczta
      Go to    ${POCZTA_URL}

Wpisz Login
      Input Text     ${XPATH_LOGIN}     ${LOGIN}

Wpisz Haslo
      Input Text     ${XPATH_HASLO}     ${HASLO_WP}

Zaloguj klik
      Click Button    ${ZALOGUJ_BUTTON}

Zdjecie zalogowany
      Capture Page Screenshot      ${ZALOGOWANY_URL}

Sprawdzenie zalogowania
      Page Should Contain     Odebrane


wylogowanie
      Close All Connections

zamkniecie przegladarki
      Close browser

Uruchomienie skryptu
    ${WYNIK}=    RUN    ./bash_test.sh lo
    Log To Console    ${WYNIK}
    Should be Equal   ${WYNIK}     127.0.0.1
