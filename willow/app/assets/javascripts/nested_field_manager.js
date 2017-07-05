class NestedFieldManager {
  constructor(element, options) {
    this.element = $(element);
    this.options = options;
    this.warningClass = options.warningClass;
    this.listClass = options.listClass;
    this.fieldWrapperClass = options.fieldWrapperClass;
    this.removeInputClass = options.removeInputClass;

    this.init();
  }

  init() {
    // this._addInitialClasses();
    this._addAriaLiveRegions()
    this._attachEvents();
    this._addCallbacks();
  }

  _addAriaLiveRegions() {
    $(this.element).find('.listing').attr('aria-live', 'polite')
  }

  _attachEvents() {
    this.element.on('click', '.remove', (e) => this.removeFromList(e));
    this.element.on('click', '.add', (e) =>this.addToList(e));
  }

  _addCallbacks() {
    this.element.bind('manage_nested_fields:add', this.options.add);
    this.element.bind('manage_nested_fields:remove', this.options.remove);
  }

  addToList( event ) {
    event.preventDefault();
    let $listing = $(event.target).closest('.multi-nested').find(this.listClass)
    let $listElements = $listing.children('li')
    let $activeField = $listElements.last()
    let $newId = $listElements.length
    let $currentId = $newId - 1
    if (this.inputIsEmpty($activeField)) {
      this.displayEmptyWarning();
      $activeField.removeAttr('style');
      // $activeField.find('.remove-box').val('0');
    } else {
      this.clearEmptyWarning();
      $listing.append(this._newField($activeField, $currentId, $newId));
    }
    this._manageFocus()
  }

  inputIsEmpty($activeField) {
    let $children = $activeField.find('.form-control').not(':hidden');
    var empty = 0;
    $children.each(function () {
      if ($.trim(this.value) === "") empty++;
    });
    return empty == $children.length;
  }

  clearEmptyWarning() {
    let $listing = $(this.listClass, this.element)
    $listing.children(this.warningClass).remove();
  }

  displayEmptyWarning() {
    let $listing = $(this.listClass, this.element)
    var $warningMessage  = $("<div class=\'message has-warning\'>cannot add another with empty field</div>");
    $listing.children(this.warningClass).remove();
    $listing.append($warningMessage);
  }

  _newField ($activeField, $currentId, $newId) {
    var $newField = this.createNewField($activeField, $currentId, $newId);
    return $newField;
  }

  _manageFocus() {
    $(this.element)
      .find(this.listClass)
      .children('li:visible:last')
      .find('.form-control')
      .filter(':visible:first').focus();
  }

  createNewField($activeField, $currentId, $newId) {
    let $newField = $activeField.clone();
    $newField
        this.updateIndexInLabel($newField, $currentId, $newId);
    let $newChildren = $newField.find('.form-control');
    $newChildren
      .val('')
      .removeProp('required')
      .removeAttr('style')
      this.updateIndexInId($newChildren, $currentId, $newId)
      this.updateIndexInName($newChildren, $currentId, $newId);
    $newChildren.first().focus();
    this.element.trigger("manage_nested_fields:add", $newChildren.first());
    return $newField;
  }

  updateIndexInLabel($newField, $currentId, $newId) {
    // Modify name in label
    let currentLabelPart = 'attributes_' + $currentId + '_'
    let newLabelPart = 'attributes_' + $newId + '_'
    $newField.find('label').each(function () {
      let currentLabel = $(this).attr('for');
      let newLabel = currentLabel.replace(currentLabelPart, newLabelPart)
      $(this).attr('for', newLabel);
    });
    return $newField;
  }

  updateIndexInId($newChildren, $currentId, $newId) {
    // modify id and name in newChildren
    let $currentIdPart = new RegExp('attributes_' + $currentId + '_');
    let $newIdPart = 'attributes_' + $newId + '_';
    $newChildren.each(function () {
      let $currentId = $(this).attr('id');
      let $newId = $currentId.replace($currentIdPart, $newIdPart)
      $(this).attr('id', $newId);
    });
    return $newChildren;
  }

  updateIndexInName($newChildren, $currentId, $newId) {
    // modify id and name in newChildren
    let $currentNamePart = new RegExp('[' + $currentId + ']');
    let $newnamePart = '[' + $newId + ']';
    $newChildren.each(function () {
      let $currentName = $(this).attr('name');
      let $newName = $currentName.replace($currentNamePart, $newnamePart)
      $(this).attr('name', $newName);
    });
    return $newChildren;
  }

  removeFromList( event ) {
    event.preventDefault();
    var $activeField = $(event.target).parents(this.fieldWrapperClass)
    $activeField.find(this.removeInputClass).val('1');
    $activeField.hide();
    this._manageFocus();
  }
}
