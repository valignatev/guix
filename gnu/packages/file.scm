;;; GNU Guix --- Functional package management for GNU
;;; Copyright © 2013 Andreas Enge <andreas@enge.fr>
;;; Copyright © 2014, 2015 Mark H Weaver <mhw@netris.org>
;;; Copyright © 2016, 2017 Efraim Flashner <efraim@flashner.co.il>
;;;
;;; This file is part of GNU Guix.
;;;
;;; GNU Guix is free software; you can redistribute it and/or modify it
;;; under the terms of the GNU General Public License as published by
;;; the Free Software Foundation; either version 3 of the License, or (at
;;; your option) any later version.
;;;
;;; GNU Guix is distributed in the hope that it will be useful, but
;;; WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;; GNU General Public License for more details.
;;;
;;; You should have received a copy of the GNU General Public License
;;; along with GNU Guix.  If not, see <http://www.gnu.org/licenses/>.

(define-module (gnu packages file)
  #:use-module (gnu packages)
  #:use-module (guix licenses)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system gnu))

(define-public file
  (package
    (replacement file/fixed)
    (name "file")
    (version "5.30")
    (source (origin
              (method url-fetch)
              (uri (string-append "ftp://ftp.astron.com/pub/file/file-"
                                  version ".tar.gz"))
              (sha256
               (base32
                "057jpcyy8ws7q4s4sm8r1rxb8xycdbng2z4y9i98f094wlr28k39"))))
   (build-system gnu-build-system)

   ;; When cross-compiling, this package depends upon a native install of
   ;; itself.
   (self-native-input? #t)

   (synopsis "File type guesser")
   (description
    "The file command is a file type guesser, a command-line tool that tells
you in words what kind of data a file contains.  It does not rely on filename
extensions to tell you the type of a file, but looks at the actual contents
of the file.")
   (license bsd-2)
   (home-page "http://www.darwinsys.com/file/")))

(define file/fixed
  (package
    (inherit file)
    (source (origin
              (inherit (package-source file))
              (patches (search-patches "file-CVE-2017-1000249.patch"))))))
