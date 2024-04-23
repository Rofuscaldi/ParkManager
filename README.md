# Park Manager

Um aplicativo de gestão de estacionamento que salva localmente quais vagas estão ocupadas e registra um histórico sobre a entrada e saída de cada veículo.

## Construção
Execute `flutter pub get` antes de rodar o app pela primeira vez. Isso garante que você obtenha todas as dependências listadas no __pubspec.yaml__.

## Arquitetura
Na camada de Apresentação (Presentation) eu uso BLoC para gerenciar o estado e divido minhas camadas conforme o Clean Architecture sugere, da seguinte forma:
![clean_arch](https://github.com/Rofuscaldi/ParkManager/assets/167842968/486781bc-ca83-4d0b-a366-664e6af2d3ff)

## Teste
Execute `flutter test` para executar todos os testes.
