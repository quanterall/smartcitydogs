exports.config = {
  notifications: false,
watcher: {
    usePolling: true
},
  // See http://brunch.io/#documentation for docs.
  files: {
    javascripts: {
      joinTo: "js/app.js"

      // To use a separate vendor.js bundle, specify two files path
      // http://brunch.io/docs/config#-files-
      // joinTo: {
      //   "js/app.js": /^js/,
      //   "js/vendor.js": /^(?!js)/
      // }
      //
      // To change the order of concatenation of files, explicitly mention here
      // order: {
      //   before: [
      //     "vendor/js/jquery-2.1.1.js",
      //     "vendor/js/bootstrap.min.js"
      //   ]
      // }
    },
    stylesheets: {
      joinTo: {
      "css/app.css": [
          "css/app.css",
          "css/login_user.css",
          "css/register_user.css",
          "node_modules/bootstrap/dist/css/bootstrap.css",
          "node_modules/slick-carousel/slick/slick.css",
          "css/show_user.css",
          "css/my_profile.css",
          "css/index_signal.css",
          "css/nav_bar.css",
          "css/show_signal.css",
          "css/registered_dogs.css",
          "css/contact.css",
          "css/project.css",
          // "css/help-page/bootstrap.css",
          "css/help-page/font-awesome.css",
          "css/help-page/linearicons.css",
          "css/help-page/magnific-popup.css",
          // "css/help-page/main.css",
          "css/help-page/nice-select.css",
          "css/help-page/owl.carousel.css",
          "css/help-page/pgwslider.css"
        ]
      }
    },
    templates: {
      joinTo: "js/app.js"
    }
  },

  conventions: {
    // This option sets where we should place non-css and non-js assets in.
    // By default, we set this to "/assets/static". Files in this directory
    // will be copied to `paths.public`, which is "priv/static" by default.
    assets: /^(static)/
  },

  // Phoenix paths configuration
  paths: {
    // Dependencies and current project directories to watch
    watched: ["static", "css", "js", "vendor"],
    // Where to compile files to
    public: "../priv/static"
  },

  
  // Configure your plugins
  plugins: {
    babel: {
      // Do not use ES6 compiler in vendor code
      ignore: [/vendor/]
    }
  },

  modules: {
    autoRequire: {
      "js/app.js": ["js/app"]
    }
  },

  npm: {
    enabled: true,
      globals: {
          jQuery: 'jquery',
          $: 'jquery',
          bootstrap: 'bootstrap'
      },
      styles: {
          bootstrap: ['dist/css/bootstrap.css'],
          "slick-carousel": ['slick/slick.css']
      }
      
  }
  
};
