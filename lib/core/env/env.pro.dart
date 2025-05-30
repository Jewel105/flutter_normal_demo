// Pro config
import 'env.dart';

const EnvConfig kProConfig = EnvConfig(
  envType: EnvType.production,
  envHttpUrl: 'https://equipment.hambit.co',
  envWsUrl: 'wss://equipment.hambit.co/api/v1/equipment/ws',
  tronUrl: 'https://tronscan.org/#/transaction/',
);
