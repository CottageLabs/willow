'use strict';

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

  /**
    For an input string, find the Nth occurence of a regex (which defines a surrounding context for an ID), 
    and then replace the old id within that occurrence with a new id.
    Parameters:
    string: the original string to be manipulated
    contextRegex: A regular expression that expresses the context surrounding the id.
      This must capture the id and also have the g flag on it so that it checks the whole string
    originalId: The ID expected to be found in the context
    newId: The ID to replace the old id
    nOccurrence: The index of that occurrence in the string, 0 indexed
    E.G
    for:
    string = "bob[0]james[1]fred[0]"
    contextRegex = "\[(\d)\]"
    originalId = 0
    newId = 2
    nOccurrence = 2
    Expected result => "bob[0]james[1]fred[2]"
  **/
function replaceIdInContext(string, contextRegex, originalId, newId, nOccurrence){
    // variable to keep the current match within the regex
    var match = null;
    // the resultin string to return. Default to the original string
    var result = string;
    // find the Nth match in the string
    // to do that we call exec on the regex N times
    for(var i = 0; i <= nOccurrence; i++){
        match = contextRegex.exec(string); 
    }
    // if we have a match, and there is a captured group, and that equals the id
    // go ahead with the replacement
    if(match && match[1] && match[1] == originalId){ 
        // replace the old id with the new in the matching string
        // E.G [0] => [1]
        var newString = match[0].replace(originalId, newId) 
        
        // insert the new id and it's context (newString) into the original string
        // at the index indicated by the match
        result = string.substring(0, match.index) + newString + string.substring(match.index + newString.length); 
    }
    return result;
}

/** replace old id with new id in the nth instance of "attributes_<id>_" **/
function replaceAttributesId(string, originalId, newId, nOccurrence){
    var regex = /attributes_(\d)+_/g;
    return replaceIdInContext(string, regex, originalId, newId, nOccurrence);
}

/** replace old id with new id in the nth instance of "[<id>]" **/
function replaceSquareBracketsId(string, originalId, newId, nOccurrence){
    var regex = /\[(\d)+\]/g;
    return replaceIdInContext(string, regex, originalId, newId, nOccurrence);
}

var NestedFieldManager = function () {
    function NestedFieldManager(element, options) {
        _classCallCheck(this, NestedFieldManager);

        this.element = $(element);
        this.options = options;
        this.warningClass = options.warningClass;
        this.listClass = options.listClass;
        this.fieldWrapperClass = options.fieldWrapperClass;
        this.removeInputClass = options.removeInputClass;
        this.nestedLevel = this.element.parents('.multi-nested').length;
        this.init();
    }

    _createClass(NestedFieldManager, [{
        key: 'init',
        value: function init() {
            // this._addInitialClasses();
            this._addAriaLiveRegions();
            this._attachEvents();
            this._addCallbacks();
        }
    }, {
        key: '_addAriaLiveRegions',
        value: function _addAriaLiveRegions() {
            $(this.element).find('.listing').attr('aria-live', 'polite');
        }
    }, {
        key: '_attachEvents',
        value: function _attachEvents() {
            var _this = this;

            this.element.on('click', '.remove', function (e) {
                return _this.removeFromList(e);
            });
            this.element.on('click', '.add', function (e) {
                return _this.addToList(e);
            });
        }
    }, {
        key: '_addCallbacks',
        value: function _addCallbacks() {
            this.element.bind('manage_nested_fields:add', this.options.add);
            this.element.bind('manage_nested_fields:remove', this.options.remove);
        }
    }, {
        key: 'addToList',
        value: function addToList(event) {
            var $target = $(event.target);
            // If the 'add another' button has been clicked for a standard multivalue input
            // inside a multi nested input, allow the hyrax javascript code to run instead.
            if($target.is('.multi_value *')) return; 
            event.preventDefault();
            event.stopPropagation();
            var $listing = $target.closest('.multi-nested').children(this.listClass);
            var $listElements = $listing.children('li');
            var $activeField = $listElements.last();
            var $newId = $listElements.length;
            var $currentId = $newId - 1;
            if (this.inputIsEmpty($activeField)) {
                this.displayEmptyWarning();
                $activeField.removeAttr('style');
                // $activeField.find('.remove-box').val('0');
            } else {
                this.clearEmptyWarning();
                $listing.append(this._newField($activeField, $currentId, $newId));
                // instantiate any mutli-nested fields or multi-value fields
                $listing.find('.multi-nested').manage_nested_fields();
                $listing.find('.multi_value').manage_fields();

            }
            this._manageFocus();
        }
    }, {
        key: 'inputIsEmpty',
        value: function inputIsEmpty($activeField) {
            var $children = $activeField.find('.form-control').not(':hidden');
            var empty = 0;
            $children.each(function () {
                if ($.trim(this.value) === "") empty++;
            });
            return empty == $children.length;
        }
    }, {
        key: 'clearEmptyWarning',
        value: function clearEmptyWarning() {
            var $listing = $(this.listClass, this.element);
            $listing.children(this.warningClass).remove();
        }
    }, {
        key: 'displayEmptyWarning',
        value: function displayEmptyWarning() {
            var $listing = $(this.listClass, this.element);
            var $warningMessage = $("<div class=\'message has-warning\'>cannot add another with empty field</div>");
            $listing.children(this.warningClass).remove();
            $listing.append($warningMessage);
        }
    }, {
        key: '_newField',
        value: function _newField($activeField, $currentId, $newId) {
            var $newField = this.createNewField($activeField, $currentId, $newId);
            return $newField;
        }
    }, {
        key: '_manageFocus',
        value: function _manageFocus() {
            $(this.element).find(this.listClass).children('li:visible:last').find('.form-control').filter(':visible:first').focus();
        }
    }, {
        key: 'createNewField',
        value: function createNewField($activeField, $currentId, $newId) {
            var $newField = $activeField.clone();
            $newField;
            this.updateIndexInLabel($newField, $currentId, $newId, this.nestedLevel);
            var $newChildren = $newField.find('.form-control');
            $newChildren.val('').removeProp('required').removeAttr('style');
            this.updateIndexInId($newChildren, $currentId, $newId, this.nestedLevel);
            this.updateIndexInName($newChildren, $currentId, $newId, this.nestedLevel);
            $newChildren.first().focus();
            this.element.trigger("manage_nested_fields:add", $newChildren.first());
            return $newField;
        }
    }, {
        key: 'updateIndexInLabel',
        value: function updateIndexInLabel($newField, currentId, newId, nestedLevel) {
            // Modify name in label
            $newField.find('label').each(function () {
                var currentLabel = $(this).attr('for');
                var newLabel = replaceAttributesId(currentLabel, currentId, newId, nestedLevel);
                $(this).attr('for', newLabel);
            });
            return $newField;
        }
    }, {
        key: 'updateIndexInId',
        value: function updateIndexInId($newChildren, currentId, newId, nestedLevel) {
            // modify id and name in newChildren
            $newChildren.each(function () {
                var currentHtmlId = $(this).attr('id');
                var newHtmlId = replaceAttributesId(currentHtmlId, currentId, newId, nestedLevel);
                $(this).attr('id', newHtmlId);
            });
            return $newChildren;
        }
    }, {
        key: 'updateIndexInName',
        value: function updateIndexInName($newChildren, currentId, newId, nestedLevel) {
            // modify id and name in newChildren
            $newChildren.each(function () {
                var currentName = $(this).attr('name');
                var newName = replaceSquareBracketsId(currentName, currentId, newId, nestedLevel)
                $(this).attr('name', newName);
            });
            return $newChildren;
        }
    }, {
        key: 'removeFromList',
        value: function removeFromList(event) {
            event.preventDefault();
            var $activeField = $(event.target).parents(this.fieldWrapperClass);
            $activeField.find(this.removeInputClass).val('1');
            $activeField.hide();
            this._manageFocus();
        }
    }]);

    return NestedFieldManager;
}();