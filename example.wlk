class Personaje {
  var property fuerza
  var property rol

  method potencialOfensivo() {
    return (fuerza * 10) + rol.potencialOfensivo()
  }

  method esInteligente() 
  method esGroso() {
    return self.esInteligente() or rol.esGroso(self)
  }
}

class Orcos inherits Personaje {
  override method esInteligente() = false
  
  override method potencialOfensivo() {
    return super() * 1.1
  }
}

class Humano inherits Personaje {
  var property inteligencia
  override method esInteligente() = inteligencia > 50
}

class Rol {
  method potencialOfensivo()
  method esGroso(personaje)
}

class Guerrero inherits Rol {
  override method potencialOfensivo() = 100
  override method esGroso(personaje) = personaje.fuerza() > 50
}

class Cazador inherits Rol {
  var property mascota

  override method potencialOfensivo() = mascota.potencialOfensivo()
  override method esGroso(personaje) = mascota.esLongeva() 
}

class Brujo inherits Rol {
  override method potencialOfensivo() = 0
  override method esGroso(personaje) = true
}

class Mascota {
  var property fuerza
  var property edad 
  var property tieneGarras

  method potencialOfensivo() {
    if (tieneGarras) {
      return fuerza * 2
    } else {
      return fuerza
    }
  }

  method esLongeva() {
    return edad > 10
  }
}

class Localidad {
  const property habitantes = []
  method potencialOfensivo() = habitantes.sum({h => h.potencialOfensivo()})

  method agregarHabitante(habitante) {
    habitantes.add(habitante)
  }

  method ocupar() {
    habitantes = if(self.esGrande(ejercito)){
      ejercito.nuevoEjercito(self)
    }
                    
  }

  method recibirAtaque(ejercito) {
    habitantes.clear()
    habitantes.addAll(ejercito.personajes())
  }
}

class Aldea inherits Localidad {
  var property tamanio

  override method recibirAtaque(ejercito) {
   habitantes.clear()
   if (ejercito.personajes() > self.habitantes()) {
    habitantes.addAll(ejercito.losMasFuertes())
   }
  }
}

class Ciudad inherits Localidad {
  override method potencialOfensivo() = super() + 300
}

class Ejercito {
  const property personajes = []

  method agregarSoldado(habitante) {
    personajes.add(habitante)
  }

  method potencialOfensivoTotal() {
    return personajes.sum({p => p.potencialOfensivo()})
  }

  method atacar(localidad) {
    if (self.potencialOfensivoTotal() > localidad.potencialOfensivo()) {
      localidad.recibirAtaque(self)
    }
  }

  method losMasFuertes() {
    
  }
}


