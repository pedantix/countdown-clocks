import { dateEncoder } from "../../src/transformations/date-encoder";

describe('dateEncoder', () => {
  it ("returns data passed in", () => {
    const data = { a: 1 };
    let transformed = dateEncoder(data);
    expect(transformed.a).toBe(1);
  });

  it ("transforms dates into iso-8601 without fractional seconds", () =>{
    const data = { date: new Date("2019-06-17T20:40:31.746Z") };
    let transformedDate = dateEncoder(data).date;
    expect(transformedDate).toEqual("2019-06-17T15:40:31-05:00");
  });
})
