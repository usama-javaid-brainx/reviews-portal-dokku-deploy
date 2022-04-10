# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "photoswipe", to: "https://ga.jspm.io/npm:photoswipe@5.2.4/dist/photoswipe.esm.js"
pin "photoswipe-lightbox", to: "https://ga.jspm.io/npm:photoswipe@5.2.4/dist/photoswipe-lightbox.esm.js"
