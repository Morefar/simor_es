module Kaminari
    module ActionViewExtension
        # Renders a helpful message with numbers of displayed vs. total entries.
        # Ported from mislav/will_paginate
        #
        # ==== Examples
        # Basic usage:
        #
        #   <%= page_entries_info @posts %>
        #   #-> Displaying posts 6 - 10 of 26 in total
        #
        # By default, the message will use the humanized class name of objects
        # in collection: for instance, "project types" for ProjectType models.
        # The namespace will be cutted out and only the last name will be used.
        # Override this with the <tt>:entry_name</tt> parameter:
        #
        #   <%= page_entries_info @posts, :entry_name => 'item' %>
        #   #-> Displaying items 6 - 10 of 26 in total
        def page_entries_info(collection, options = {})
            entry_name = if options[:entry_name]
                             options[:entry_name]
                         elsif collection.is_a?(::Kaminari::PaginatableArray)
                             'entry'
                         else
                             if collection.respond_to? :model  # DataMapper
                                 collection.model.model_name.human.downcase
                             else  # AR
                                 collection.model_name.human.downcase
                             end
                         end
            unless collection.total_count == 1
                entry_name = entry_name.method(:pluralize).parameters.flatten.include?(:locale) ? entry_name.pluralize(options[:locale]) : entry_name.pluralize
            end

            if collection.total_pages < 2
                t('helpers.page_entries_info.one_page.display_entries', :entry_name => entry_name, :count => collection.total_count)
            else
                first = collection.offset_value + 1
                last = collection.last_page? ? collection.total_count : collection.offset_value + collection.limit_value
                t('helpers.page_entries_info.more_pages.display_entries', :entry_name => entry_name, :first => first, :last => last, :total => collection.total_count)
            end.html_safe
        end
    end
end
