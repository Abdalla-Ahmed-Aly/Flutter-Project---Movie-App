class AppException {
 final String message;
 const AppException(this.message);
  
}
class RemoteException extends AppException {
 const RemoteException( super.message) ;
}