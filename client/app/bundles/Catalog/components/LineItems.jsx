import React from 'react';
import LineItem from './LineItem';

const LineItems = React.createClass ({

  handleRemoveFromCart: function(id) {   
    // call handleRemoveFromCart in Cart to handle it
    this.props.handleRemoveFromCart(id);
  },

  render: function() {
    // populate an array "line_items" with 
    // a collection of LineItem components
    var lineItems = [];
    var total_price =0;

    this.props.lineItems.forEach(function(lineItem) {
      total_price+= parseFloat(lineItem.total_price);
      lineItems.push(<LineItem lineItem={lineItem}
                         key={'lineItem' + lineItem.id}
                         handleRemoveFromCart={this.handleRemoveFromCart}
                         />);
    }.bind(this));

    return(
      <table>
        <tbody>
          {lineItems}
          <tr className= "total_line">
          
          <td colSpan="2">Total </td>
          <td>${total_price}</td>
          </tr>
          <tr className= "total_line">
          
          <td colSpan="2"> </td>
          <td><a className="btn btn-primary btn-xs"
            onClick={this.handleEmptyCart} >
            Empty Cart
          </a></td>
          </tr>
        </tbody>
      </table>
    )
  }
});

export default LineItems;