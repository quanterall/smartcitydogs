'use strict';

/**
* The underneath has been adapted from:
* https://github.com/phoenixframework/phoenix_html/blob/51b0866afb3907cda652b94e8be77bc6929608d7/priv/static/phoenix_html.js
*/
function isLinkToSubmitParent(element) {
  var isLinkTag = element.tagName === 'A';
  var shouldSubmitParent = element.getAttribute('data-submit') === 'parent';

  return isLinkTag && shouldSubmitParent;
}

function getClosestForm(element) {
  while (element && element !== document && element.nodeType === Node.ELEMENT_NODE) {
    if (element.tagName === 'FORM') {
      return element;
    }
    element = element.parentNode;
  }
  return null;
}

function didHandleSubmitLinkClick(element) {
  while (element && element.getAttribute) {
    if (isLinkToSubmitParent(element)) {
      var message = element.getAttribute('data-confirm');
      if (typeof(window.jQuery) != undefined && $('#phoenix-bs-modal').length) {
        willHandleConfirmLinkClick($('#phoenix-bs-modal'), element, function() {
          getClosestForm(element).submit();
        });
      } else if (message === null || confirm(message)) {
        getClosestForm(element).submit();
      }
      return true;
    } else {
      element = element.parentNode;
    }
  }
  return false;
}

window.addEventListener('click', function (event) {
  if (event.target && didHandleSubmitLinkClick(event.target)) {
    event.preventDefault();
    return false;
  }
}, false);

/**
* willHandleConfirmLinkClick (modal, element, callback) takes (1) a jQuery DOM
*   element that conforms loosely to the Bootstrap modal component described at
*   https://getbootstrap.com/javascript/#modals, (2) the DOM element that fired
*   the event that requires confirmation, and (3) a callback that is called
*   after the user confirms his/her action using the .btn-primary button in the
*   modal dialogue.
*/
function willHandleConfirmLinkClick(modal, element, callback) {
  var regular = modal.find('.modal-body p').text();
  var message = element.getAttribute('data-confirm');
  if (message === null) return callback();
  // Prepare to show the modal
  modal.on('show.bs.modal', function(e) {
    modal.find('.modal-body p').text(message);
    modal.find('.btn-primary').click(function(e) {
      callback();
      modal.modal('toggle');
    });
  });
  // Return the modal to the default state when hiding
  modal.on('hide.bs.modal', function(e) {
    modal.find('.btn-primary').off('click');
    modal.find('.modal-body p').text(regular);
  });
  // Toggle the modal
  modal.modal('toggle');
}