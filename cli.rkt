#!/usr/bin/env racket

#|
MIT License

Copyright (c) 2022 Timofey Chuchkanov

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
|#

#lang racket/base

(require "certfresh.rkt"
         racket/string
         racket/cmdline)

(define path (make-parameter ""))
(define diff (make-parameter 30))

(define (check-expiry)
  (cond
    [(not (non-empty-string? (path)))
     (displayln "The certificate path must be specified!")]
    [else ((lambda ()
             (define expires (cert-expires-soon? #:cert-path (path)
                                                 #:acceptable-days-diff (diff)))
             (cond
               [(eq? expires 'file-not-found)
                (displayln "The cert file not found!")]
               [expires
                (displayln "The certificate expires soon! Trying to renew...")]
               [(not expires)
                (displayln "The certificate doesn't need to be updated yet.")])))]))

(command-line #:program "certfresh"
              #:once-each
              (("-c" "--check-expiry") PATH
                                       ("Check if the specified X.509 certificate expires in <acceptable-diff> days."
                                        "Where <acceptable-diff> is provided as an option.")
                                       (path PATH))
              (("-d" "--acceptable-days-diff") DIFF
                                               ("A number of days between the current date and certificate expiry date."
                                                "If the certificate expiry date is less than or equal to the diff number, the certificate is considered to be expired soon."
                                                "The default value is 30 days.")
                                               (diff (string->number DIFF)))
              #:args () 
              (check-expiry))