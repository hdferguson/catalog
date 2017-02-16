import React from 'react';
import LineItems from './LineItems';
import axios from 'axios';

const Cart = React.createClass ({
  getInitialState: function() {
    return {  
        // states of Cart
        lineItems: [],
        total_price: 0
    };
  },

 componentDidMount: function() {
        // send an HTTP get message to
        // request json data from the server at the url 
        // '/carts/'+this.props.id
        // and update the states with it
        var self = this;

    axios.defaults.headers.common['X-Requested-With'] = "XMLHttpRequest";
    axios.get('/carts/' + this.props.id)
        .then(function (response) {
            //console.log(response.data);
            self.setState({ lineItems: response.data.line_items, total_price: response.data.total_price });
        })
        .catch(function (error) {
            console.log(error);
        });
  },

  handleRemoveFromCart: function(id){
        // send an HTTP patch message to
        // request json data from the server at the url 
        // '/line_items/'+id+'/decrement'
        // and update the states with it
    var self = this;

    axios.defaults.headers.common['X-Requested-With'] = "XMLHttpRequest";
    axios.post('/line_items', {line_item_id: id}, '/decrement')
        .then(function (response) {
            console.log(response);
            self.refs.cart.handleRemoveFromCart(response.data);
         })
        .catch(function (error) {
            console.log(error);
            alert('Cannot remove cart: ', error);
    });
  },


  handleEmptyCart: function(){
        // send an HTTP delete message to
        // request json data from the server at the url 
        // '/carts/'+this.props.id
        // and update the states with it
  
      var self = this;

    axios.defaults.headers.common['X-Requested-With'] = "XMLHttpRequest";
    axios.post('/carts/'+ this.props.id)
        .then(function (response) {
            console.log(response);
            self.refs.cart.handleEmptyCart(response.data);
         })
        .catch(function (error) {
            console.log(error);
            alert('Cannot empty cart: ', error);
    });
  },

  handleAddToCart: function(cart){
        // update the states with "cart"
        // that comes from the line "self.refs.cart.handleAddToCart(response.data);"
        // in the "Cart" component
        var self = this;
        self.setState({lineItems: cart.line_items, total_price: cart.total_price})
  },
  render: function() {
    if (this.state.total_price != 0) {
      return(
        <div className="carts">
          <h2>Your Cart</h2>
          <LineItems lineItems={this.state.lineItems}
                total_price={this.state.total_price}/>
          
        </div>
      )
    }
    else {
      return (
        <div className="carts">
          <h2>Your Cart</h2>
        </div>
      );
    }
  }
});

export default Cart;