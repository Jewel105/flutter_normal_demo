// Dev config
import 'env.dart';

const EnvConfig kDevConfig = EnvConfig(
  envType: EnvType.development,
  envHttpUrl: 'https://cashier-equipment.hambit.co:16088',
  envWsUrl: 'wss://cashier-equipment.hambit.co:16088/api/v1/equipment/ws',
  tronUrl: 'https://nile.tronscan.org/#/transaction/',
);
