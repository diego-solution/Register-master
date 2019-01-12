/**
Mixin to implement messaging capability on components
**/
import moment from 'moment'

export const helpers = {
  filters: {
    truncate: function (text, stop, clamp) {
      return text.slice(0, stop) + (stop < text.length ? clamp || '...' : '')
    },
    euro_date: function (value) {
      if (!value) return ''
      return moment(String(value)).format('DD MMM YYYY')
    }
  },
  // methods: {
  //   yourMethod(server_response){
  //     //do something
  //   }
  // }
}
