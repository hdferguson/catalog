import React, { PropTypes } from 'react';
import BookList from './BookList';
import axios from 'axios';

const Catalog = React.createClass ({
  getInitialState: function() {
        return {  books: [], 
              sort: "popularity",
              order: "asc" 
           };
  },  

  componentDidMount: function() {
    var self = this;

    axios.defaults.headers.common['X-Requested-With'] = "XMLHttpRequest";
    axios.get('/')
        .then(function (response) {
            console.log(response.data);
            self.setState({ books: response.data })
        })
        .catch(function (error) {
            console.log(error);
        });
  },

  handleSortColumn: function(name, order) {
    if (this.state.sort != name) {
        order = 'asc';
    }

    var self = this;

    axios.defaults.headers.common['X-Requested-With'] = "XMLHttpRequest";
    axios.get('/', {params: {sort_by: name, order: order }})
      .then(function (response) {
        console.log(response.data);
        self.setState({ books: response.data, sort: name, order: order });
      })
      .catch(function (error) {
        console.log(error);
        alert('Cannot sort events: ', error);
    });

},
  
  render() {
    return (
      <div className="container">
        <div className="row">
          <div className="col-md-12">
              <BookList   books={this.state.books}
                          sort ={this.state.sort}
                          order={this.state.order}
                          handleSortColumn={this.handleSortColumn}/>
          </div>
        </div>
      </div>
    );
  }
});

export default Catalog;

