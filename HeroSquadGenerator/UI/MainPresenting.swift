protocol MainPresenting {

  func createNewSquad()
  func showResponse(from request: RequestEntity)
  func selectLatestSquad()
  func didSelect(_ request: RequestEntity)

}
