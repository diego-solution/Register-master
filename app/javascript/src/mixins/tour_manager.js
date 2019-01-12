/**
Mixin to implement messaging capability on components
**/

export const tour = {
  methods: {
    startTour(id){
      if(this.$cookie.get(id , "success", {domain: 'eventfuel'})){
        return
      }
      this.$cookie.set(id, "success", {expires: '1Y'})
      return this.$tours[id].start()
    },
    resetTour(id) {
      return this.$cookie.delete(id, {domain: 'eventfuel'})
    }
  }
}
