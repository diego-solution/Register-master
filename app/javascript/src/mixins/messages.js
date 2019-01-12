/**
Mixin to implement messaging capability on components
**/
export const messages = {
  methods: {
    displaySuccessMessage(server_response){
      // const answer = this.handleErrors(server_response);
      this.$toast.open({
        duration: 4000,
        message: server_response.data.message,
        position: 'is-top',
        type: 'is-success'
      })
    },
    displayErrorMessage(server_response){
      if (server_response == undefined || server_response == null){
        return
      }
      const error = this.handleErrors(server_response);
      this.$toast.open({
        duration: 4000,
        message: error["message"],
        position: 'is-top',
        type: 'is-danger'
      })
    },
    handleErrors(error) {
      var errorMessage = " ";
      var debugInfo = " ";
      var status = "";
      if (error.response) {
        // The request was made and the server responded with a status code
        // that falls out of the range of 2xx
        if(error.response.data.message != undefined){
          errorMessage = error.response.data.message
          debugInfo = error.response.data.debug_info
        }else{
          errorMessage = error.response.statusText
          debugInfo = error.response.data
        }
        status = error.response.status
      } else if (error.request) {
        // The request was made but no response was received
        errorMessage = error.request.statusText
      } else {
        // Something happened in setting up the request that triggered an Error
        errorMessage = "Something went wrong. Please try again or contact support."
      }

      return {
        message: errorMessage,
        debug_info: debugInfo,
        code: status
      }
    }

  }
}
