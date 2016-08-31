# Color Kata

Congratulations on shipping the first part!

## The Problem
As it turns out, the (virtual) vendors we interact with want to be able to give us color values that are not always in the nicely standard ranges of `0..255` for RGB and `0..1` for CMYK.  Instead, they want to be able to specify an arbitrary radix instead.

However, we also can't break compatibility with our other (fake) users of our software.

## What is a Radix?
In color math, the radix is the maximum value that the individual color components can have.  For example, with an RGB color as we normally think of them, you can have values between 0 and 255, which means the radix is 255.

Similarly, with CMYK colors as we normally think of them, the values that are allowable are between 0 and 1, which means the radix is 1.0.  Another common radix for CMYK colors is 100, which means the range of values permitted is `0..100`.

## Part II
To run the specs, simply execute `bundle exec rspec`.

Once you complete Part II, **and are satisfied with your work**, make a commit and zip it up for us.  The exercise is now complete!
