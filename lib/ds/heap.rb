require_relative './doubly_linked_list'

class Heap < DoublyLinkedList
  
  def insert_smallest_to_highest(data)
    new_node = Node.new(data)
  
    if @head.nil?
      @head = new_node
      @tail = new_node
    elsif data.frequency <= @head.data.frequency
      update_head_with(new_node)
    elsif data.frequency >= @tail.data.frequency
      update_tail_with(new_node)
    else
      differemce_with_tail = (data.frequency - @tail.data.frequency).abs
      differemce_with_head = (data.frequency - @head.data.frequency).abs

      if differemce_with_tail <= differemce_with_head
        current = @tail

        while current.prev && current.prev.data.frequency > data.frequency
          current = current.prev
        end

        new_node.prev = current
        new_node.next = current.next
        current.next.prev = new_node
        current.next = new_node
      else
        current = @head

        while current.next && current.next.data.frequency < data.frequency
          current = current.next
        end

        new_node.prev = current.prev
        new_node.next = current
        current.prev.next = new_node
        current.prev = new_node
      end
    end

    @size += 1
  end
end