enum ItemStatus {
  InProgress,
  Done,
}

enum ItemColor {
  Green,
  White,
  Yellow,
}

int getPriorityIndex(ItemColor itemColor) {
  switch (itemColor) {
    case ItemColor.Green:
      return 0;
    case ItemColor.White:
      return 1;
    case ItemColor.Yellow:
      return 2;
    default:
      return -1;
  }
}
