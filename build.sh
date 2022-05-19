#!/bin/bash
chmod +x ./bin/mdbook
cd books/rust && ../../bin/mdbook clean && ../../bin/mdbook build
cd ../../books/wiki && ../../bin/mdbook clean && ../../bin/mdbook build
