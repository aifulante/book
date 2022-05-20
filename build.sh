#!/bin/bash
chmod +x ./bin/mdbook
cd books/rust && ../../bin/mdbook clean && ../../bin/mdbook build
cd ../../books/graph && ../../bin/mdbook clean && ../../bin/mdbook build
