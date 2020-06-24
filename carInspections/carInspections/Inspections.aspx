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

        /*.table-row-odd-even:nth-child(even) {
            background-color:white;
        }*/

        .table-row-odd-even:nth-child(odd) {
            background-color:lightgrey;
        }

        .btn-book:hover {
            cursor:pointer;
        }

        .pad-4x {
            padding:5% 1%;
        }

        .rounded-corners {
            border-radius:8px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">

    </form>
        <div id="app">
        <section v-if="errored">
            <p>We're sorry, we're not able to retrieve this information at the moment, please try back later</p>
        </section>
        <section v-else>
            <ul style="display:none;">
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


            <table>
                <thead>
                    <td>                        
                        <table>
                            <thead>
                                <td>
                                    Booking Date
                                </td>
                                <td>
                                    Time Slot
                                </td>
                                <td>
                                    Action
                                </td>
                            </thead>
                        </table>
                    </td>
                </thead>
                <tr v-for="details in info">
                    <td>
                        <table style="border-collapse:collapse;">
                            <tr v-for="det in details.bookingDetails" class="table-row-odd-even">
                                <td class="pad-4x">
                                     {{ details.bookingDate | formatDate}}&nbsp;&nbsp;&nbsp;
                                </td>
                                <td>
                                    {{ det.timeSlot}}
                                </td>
                                <td class="pad-4x">
                                     <button class="btn-book rounded-corners" v-if='!det.booked' v-on:click="bookSlot(details.bookingDate,det.slotNo,1)">Book this slot </button>                                                                                                                                                
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </section>
    </div>
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
            methods: {
                bookSlot: function (bookingDate,slotNo,userId) {
                    console.log('You have selected ' + moment(String(bookingDate)).format('YYYY-MMM-DD') + ' Slot : ' + slotNo);
                    var request = {
                        "bookingDate": moment(String(bookingDate)).format('YYYY-MM-DD').toString(),
                        "bookingSlotId": slotNo.toString(),
                        "userId": userId
                    };
                    axios
                        .post('http://localhost:4663/api/Inspect/GetBooking', {
                            body: request,
                            headers : {
                                'Content-Type': 'application/x-www-form-urlencoded'
                            }   
                        })
                        .then(response => { this.info = response })
                        .then(console.log('post Reponse ' + this.info))
                        .catch(error => {
                            console.log(error)
                            this.errored = true
                        })
                }
            },
            filters: {
                formatDate: function (value) {
                    return value==null? null :moment(String(value)).format('DD/MMM/YYYY')
                }
            }
        })
    </script>
</body>
</html>
