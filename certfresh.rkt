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

(require x509
         gregor
         racket/class
         racket/contract)

(provide (contract-out
          [cert-expires-soon? (-> #:cert-path string?
                                  #:acceptable-days-diff integer?
                                  (or/c boolean? symbol?))]))

;; (cert-expires-soon? #:cert-path #:acceptable-days-diff) -> (or/c boolean? symbol?)
;;   cert-path : string?
;;   acceptable-diff : number?
;;
;; Check if the specified X.509 certificate expires in <acceptable-diff> days.
;; If there's an error, it's message is returned as a symbol.
;; Otherwise, a boolean value is returned.
(define (cert-expires-soon? #:cert-path path #:acceptable-days-diff diff)
  (if (not (file-exists? path))
      'file-not-found
      (let*
          ([CERT         (car (pem-file->certificates path))]
           [CURRENT-DATE (->date (now))]
           [TARGET-DATE  (->date
                          (posix->datetime
                           (cadr ;; The second value of the list is the expiry date in POSIX format.
                            (send CERT get-validity-seconds))))])
        (if (date<=? (-days TARGET-DATE diff)
                     CURRENT-DATE)
            #t
            #f))))