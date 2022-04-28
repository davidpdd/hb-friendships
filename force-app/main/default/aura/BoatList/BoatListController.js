({
  doInit: function (component, event, helper) {
    const action = component.get("c.getBoats")
    action.setParams({
      boatTypeId: ''
    })
    action.setCallback(this, function (response) {
      // verifie si tout s'est bien passe
      const state = response.getState()

      console.log(state)

      // Si ok
      if (state === "SUCCESS") {
        // recupere la valeur retournee
        const boats = response.getReturnValue()

        // faire passer cette valeur retournee au front
        component.set("v.boats", boats)

        console.log(JSON.stringify(boats))

      } else {
        // gerer l'erreur
      }
    })

    // SUPER IMPORTANT
    $A.enqueueAction(action)

  },

})