import moment from 'moment';

moment.fn.toJSON = function() { return this.format(); }

export function dateEncoder(data) {
  //return "2019-06-17T17:35:54"
  Object.keys(data).forEach((key) => {
    if (data[key] instanceof Date) {
      const date = data[key];
      data[key] = moment(date).toJSON();
    }
  });
  return data;
}
