<template>
  <transition class="fade">
    <div class="m-checked-actions" v-show="totalChecked > 0">
      <p><span>Total checked:</span> {{ totalChecked }}</p>
      <button class="button is-small is-outlined is-black" @click="clear">Clear checked</button>
      <button class="button is-small is-danger" @click="confirm">Delete</button>
    </div>
  </transition>
</template>

<script>
  export default {
    props:{
      checkedRows: {
        type: Array,
        required: true,
        default: []
      },
    },
    computed: {
      // a computed getter
      totalChecked: function () {
        return this.checkedRows.length
      }
    },
    methods: {
      clear(){
        // this.$toast.open("clear checked")
        this.$emit('update:checkedRows', [])
      },
      confirm(){
        this.$dialog.confirm({
          title: 'Deleting items',
          message: 'Are you sure you want to <b>delete</b> these items? This action cannot be undone.',
          confirmText: 'Delete',
          type: 'is-danger',
          hasIcon: true,
          onConfirm: () => this.delete()
        })
      },
      delete(){
        this.$emit("deleteData", this.checkedRows)
        this.$emit('update:checkedRows', [])
      }
    }
  }
</script>
