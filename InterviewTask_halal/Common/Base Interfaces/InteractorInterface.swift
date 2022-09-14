protocol InteractorInterface: class {
    var services: APIServicesInterfaces { get set }

    init(services: APIServicesInterfaces)
}

extension InteractorInterface {
}
