#!/usr/bin/env racket
#lang racket/base

;;; https://docs.racket-lang.org/guide/scripts.html

; (printf "Given arguments: ~s\n"
;   (current-command-line-arguments))

(define (my-+ a b)
  (if (zero? a) b (my-+ (sub1 a) (add1 b))))

(define (my-* a b)
  (if (zero? a) b (my-* (sub1 a) (my-+ b b))))

(provide my-+
         my-*)
