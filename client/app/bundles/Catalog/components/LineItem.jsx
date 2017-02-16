import React from 'react';

const LineItem = React.createClass ({
  propTypes: {
    // types of props
    quantity: React.PropTypes.number,
    title: React.PropTypes.string,
    total_price: React.PropTypes.number
  },

  handleRemoveFromCart: function(e) {   
    // call handleRemoveFromCart in LineItems to handle it
    this.props.handleRemoveFromCart(this.props.listItem.id);
  },

  render: function() {

    return(
      <tr className="entry">
        <td>{this.props.lineItem.quantity}</td>
    <td>{this.props.lineItem.title}</td>
    <td>${this.props.lineItem.total_price}</td>
    <td><a className="btn btn-primary btn-xs"
            onClick={this.handleRemoveFromCart} >
            -
          </a></td>

      </tr>
    )
  }
});

export default LineItem;