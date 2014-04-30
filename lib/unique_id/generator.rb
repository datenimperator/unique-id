module Unique
  class Generator
    attr_reader :attribute

    DEFAULT = {
      start: 1,
      scoped_by: nil,
      formatter: nil
    }

    def initialize(attribute, opts={})
      @attribute = attribute
      @opts = DEFAULT.merge(opts)
    end

    def scope
      @opts[:scoped_by]
    end

    def formatter
      @opts[:formatter]
    end

    def next(opts)
      _scope = opts[:scope].nil? ? nil : opts[:scope].to_s
      _type  = opts[:type]

      table = Arel::Table.new(:unique_ids)
      query = table
        .project( table[:value].maximum.as('v1') )
        .where( table[:type].eq(_type).and(table[:scope].eq(_scope)) )
      result = ActiveRecord::Base.connection.execute(query.to_sql).first
      max = result.is_a?(Hash) ? result['v1'] : result[0]

      next_value = max.nil? ? @opts[:start] : max.to_i + 1

      ins_query = table.create_insert
      ins_query.into table
      ins_query.insert table[:type]=>_type, table[:scope]=>_scope, table[:value]=>next_value
      result = ActiveRecord::Base.connection.insert(ins_query, nil, nil, next_value)
      raise "Unexpected result: #{result}" unless result == next_value

      next_value
    end
  end
end
