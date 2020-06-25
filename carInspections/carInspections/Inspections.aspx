<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Inspections.aspx.cs" Inherits="carInspections.Inspections" %>

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
            border-radius:5px;
        }

        .width-5 {
            width:5rem;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:HiddenField ID="hfUserId" runat="server" />
    </form>
                        <div class="container h-100">                            
                            <div class="row justify-content-center align-items-center pt-5">                                   
                                <div id="app">
                                     <div>
                                         <table style="border:none;border-collapse:collapse;">
                                             <tr>
                                                 <td>
                                                     <vuejs-datepicker placeholder="Click here to select a date" disabled-dates="state.disabledDates" :highlighted="state.highlighted" @selected="dateSelected" ></vuejs-datepicker>
                                                 </td>
                                                 <td>
                                                     <button class="btn btn-link" v-on:click="SignOut">Sign Out</button>
                                                 </td>
                                             </tr>
                                         </table>                                                                                  
                                     </div>
                                <section v-if="errored">
                                    <p>We're sorry, we're not able to retrieve this information at the moment, please try back later</p>
                                </section>
                                <section v-else>
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
                                                            &nbsp;&nbsp;&nbsp;Action&nbsp;&nbsp;
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
                                                        <td class="pad-4x width-5">
                                                             <button class="btn-book rounded-corners" v-if='!det.booked' v-on:click="bookSlot(details.bookingDate,det.slotNo)">Book Slot? </button>                                                                                                                                                
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </section>
                            </div>
                            </div>
                        </div>



    <script src="https://cdn.jsdelivr.net/npm/vue@2.6.11"></script>
    <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.27.0/moment.min.js" integrity="sha256-ZsWP0vT+akWmvEMkNYgZrPHKU9Ke8nYBPC3dqONp1mY=" crossorigin="anonymous"></script>
    <!--Font Awesome-->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.1/js/all.min.js" integrity="sha256-HkXXtFRaflZ7gjmpjGQBENGnq8NIno4SDNq/3DbkMgo=" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.1/css/all.min.css" integrity="sha256-2XFplPlrFClt0bIdPgpz8H7ojnk10H69xRqd9+uTShA=" crossorigin="anonymous" />

    <script src="https://unpkg.com/vuejs-datepicker"></script>
    <!--Sweet Alert2-->
    <script src="https://cdn.jsdelivr.net/npm/vue-sweetalert2-component@1.0.1/dist/vue-sweetalert2-component.min.js"></script>

    <script>
        var state = {
            disabledDates: {
                days: [0], // Disable Saturday's and Sunday
            },            
        };

        new Vue({
            el: '#app',
            data () {
                return {
                    info: null,
                    errored : false
                }
            },
            components: {
                vuejsDatepicker,
                VueSweetAlert2Component
            },
            mounted () {
            },
            methods: {
                SignOut:function(){
                    window.location.href = "/SignIn.aspx";
                },
                dateSelected: function(date) {
                    var bBookingDate = moment(String(date)).format('YYYY-MM-DD').toString();

                    const dayOfWeek = moment(date).day();
                    if (dayOfWeek == 0) {
                        alert('No Inspections on Sunday'); 
                    } else {
                        axios
                          .get('http://localhost:4663/api/Inspect/GetBooking?bookingDate=' + bBookingDate)
                          .then(response => (this.info = response))
                          .catch(error => {
                              console.log(error)
                              this.errored = true
                          })
                    }

                },
                bookSlot: function (bookingDate,slotNo) {
                    console.log('You have selected ' + moment(String(bookingDate)).format('YYYY-MMM-DD') + ' Slot : ' + slotNo);
                    var userId = document.getElementById('<%= hfUserId.ClientID%>').value;
                    var request = {
                        "bookingDate": moment(String(bookingDate)).format('YYYY-MM-DD').toString(),
                        "bookingSlotId": slotNo.toString(),
                        "userId": userId
                    };

                    const headers = {
                        'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8'
                    };
                    axios
                        .post('http://localhost:4663/api/Inspect/GetBooking',
                            request,
                            headers
                        )
                        .then( response => 
                            //console.log(response.data)
                            alert(response.data)
                        )
                        .then(response => {
                            axios
                              .get('http://localhost:4663/api/Inspect/GetBooking?bookingDate=' + moment(String(bookingDate)).format('YYYY-MM-DD').toString())
                              .then(response => (this.info = response))
                              .catch(error => {
                                  console.log(error)
                                  this.errored = true
                              })
                        })
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
