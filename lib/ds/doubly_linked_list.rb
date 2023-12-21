class DoublyLinkedList
  attr_reader :head, :tail, :size

  class Node
    attr_accessor :data, :prev, :next

    def initialize(data)
      @data = data
      @prev = nil
      @next = nil
    end
  end

  def initialize
    @head = nil
    @tail = nil
    @size = 0
  end

  def append(data)
    new_node = Node.new(data)

    if @head.nil?
      @head = new_node
      @tail = new_node
    else
      new_node.prev = @tail
      @tail.next = new_node
      @tail = new_node
    end

    @size += 1
  end

  def prepend(data)
    new_node = Node.new(data)

    if @head.nil?
      @head = new_node
      @tail = new_node
    else
      new_node.next = @head
      @head.prev = new_node
      @head = new_node
    end

    @size += 1
  end

  def pop
    return nil if @tail.nil?

    if @head == @tail
      data = @head.data
      @head = nil
      @tail = nil
    else
      data = @tail.data
      @tail = @tail.prev
      @tail.next = nil
    end

    @size -= 1
    data
  end

  def shift
    return nil if @head.nil?

    if @head == @tail
      data = @head.data
      @head = nil
      @tail = nil
    else
      data = @head.data
      @head = @head.next
      @head.prev = nil
    end

    @size -= 1
    data
  end

  def to_a
    array = []
    current = @head

    while current
      array << current.data
      current = current.next
    end

    array
  end

  private

  def update_head_with(node)
    node.prev = nil
    node.next = @head
    @head.prev = node
    @head = node  
  end

  def update_tail_with(node)
    node.prev = @tail
    @tail.next = node
    @tail = node
  end
end
