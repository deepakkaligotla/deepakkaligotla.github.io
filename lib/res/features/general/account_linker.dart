import '../../../res/features/general/providers/storage_providers_setup.dart';
import '../../../model/final_model.dart';


Future<void> linkSignedInAccount(FinalModel linkModel) async {
  if (linkModel.userDetails.isAnonymous!) {
    await remoteStorageProvider.deleteInRemoteStorage(linkModel.userDetails.uid!);
  }
  await remoteStorageProvider.linkAccountInRemoteStorage(modelProvider.finalModel);
  localStorageProvider.saveToLocalStorage(remoteStorageProvider.remoteStorage).then((value) async {
    await modelProvider.setModel(localStorageProvider.localStorage);
  });
}
