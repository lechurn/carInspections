<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Inspections.aspx.cs" Inherits="carInspections.Inspections" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        ul li {
            list-style-type:none;
        }

        .d-inline {
            display:inline;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div id="app">
        <section v-if="errored">
            <p>We're sorry, we're not able to retrieve this information at the moment, please try back later</p>
        </section>
        <section v-else>
            <ul>
                <li v-for="details in info">
                    <table>
                        <tr>
                            <th>
                                Booking Date
                            </th>
                            <th>
                                Time Slot
                            </th>
                            <th>
                                Action
                            </th>
                        </tr>
                        <tr v-for="det in details.bookingDetails">
                            <td>
                                {{ details.bookingDate | formatDate}}
                            </td>
                            <td>
                                {{ det.timeSlot}}
                            </td>
                            <td>
                               <button class="btn">Book this Slot</button>    
                            </td>
                        </tr>
                    </table>
                </li>
            </ul>
        </section>
    </div>
    </form>
    <script src="https://cdn.jsdelivr.net/npm/vue@2.6.11"></script>
    <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.27.0/moment.min.js" integrity="sha256-ZsWP0vT+akWmvEMkNYgZrPHKU9Ke8nYBPC3dqONp1mY=" crossorigin="anonymous"></script>
    <script>
        new Vue({
            el: '#app',
            data () {
                return {
                    info: null,
                    errored : false
                }
            },
            mounted () {
                axios
                  .get('http://localhost:4663/api/Inspect/GetBooking?bookingDate=2020-06-27')
                  .then(response => (this.info = response))
                  .then(console.log('ubfi ' + this.info))
                  .catch(error => {
                      console.log(error)
                      this.errored = true
                  })
            },
            filters: {
                formatDate: function (value) {
                    return moment(String(value)).format('DD/MMM/YYYY')
                }
            }
        })
    </script>
</body>
</html>
