import React, { PropTypes } from 'react';
import BookList from './BookList';

const Catalog = React.createClass ({
  getInitialState: function() {
        return { books: [] };
  },  

  componentDidMount: function() {
        this.setState({ books: this.props.catalog });
  },

  render() {
    return (
      <div className="container">
        <div className="row">
          <div className="col-md-12">
              <BookList books={this.state.books}/>
          </div>
        </div>
      </div>
    );
  }
});

export default Catalog;

