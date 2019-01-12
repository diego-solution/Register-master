import TableFooter from './table-footer'
import TableEmpty from './table-empty'
import DataTable from './data-table'

export default {
  install (vm) {
    vm.component('table-footer', TableFooter)
    vm.component('table-empty', TableEmpty)
    vm.component('data-table', DataTable)
  }
}
