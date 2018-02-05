'use strict';

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

/** add a replaceNthOccurrence method to String. 
    Replaces the Nth occurrence of a 'searchValue' with 'newValue' in string
    Where N is 0 indexed.
    E.G 
    "hello bob, how are you bob, are you doing well bob".replaceNthOccurrence('bob', 'jane', 1);
    => "hello bob, how are you jane, are you doing well bob"
**/
/** note this cannot take regular expressions **/
if (!String.prototype.replaceNthOccurrence) {
    String.prototype.replaceNthOccurrence = function(searchValue, newValue, n) {
        var index = 0;
        for(var i = 0; i <= n; i++){ // do it n times
            // get the index of the search value, starting from the character after the previous index
            index = this.indexOf(searchValue, index+1); 
        }
        if (index >= 0) {
            var str = this.substring(0, index) + newValue + this.substring(index + searchValue.length);
            return str;
        }
        return this.toString();
    };
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
        value: function updateIndexInLabel($newField, $currentId, $newId, nestedLevel) {
            // Modify name in label
            var currentLabelPart = 'attributes_' + $currentId + '_';
            var newLabelPart = 'attributes_' + $newId + '_';
            $newField.find('label').each(function () {
                var currentLabel = $(this).attr('for');
                var newLabel = currentLabel.replaceNthOccurrence(currentLabelPart, newLabelPart, nestedLevel);
                $(this).attr('for', newLabel);
            });
            return $newField;
        }
    }, {
        key: 'updateIndexInId',
        value: function updateIndexInId($newChildren, $currentId, $newId, nestedLevel) {
            // modify id and name in newChildren
            var $currentIdPart = 'attributes_' + $currentId + '_';
            var $newIdPart = 'attributes_' + $newId + '_';
            $newChildren.each(function () {
                var $currentId = $(this).attr('id');
                var $newId = $currentId.replaceNthOccurrence($currentIdPart, $newIdPart, nestedLevel);
                $(this).attr('id', $newId);
            });
            return $newChildren;
        }
    }, {
        key: 'updateIndexInName',
        value: function updateIndexInName($newChildren, $currentId, $newId, nestedLevel) {
            // modify id and name in newChildren
            var $currentNamePart = '[' + $currentId + ']';
            var $newnamePart = '[' + $newId + ']';
            $newChildren.each(function () {
                var $currentName = $(this).attr('name');
                var $newName = $currentName.replaceNthOccurrence($currentNamePart, $newnamePart, nestedLevel);
                $(this).attr('name', $newName);
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