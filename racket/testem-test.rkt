#!/usr/bin/env racket
#lang racket/base

(require rackunit
         "testem.rkt")

(check-equal? (my-+ 1 1) 2 "Simple addition")
(check-equal? (my-* 1 2) 4 "Simple multiplication")
