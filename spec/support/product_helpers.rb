def create_variants_for(product)
  option_type = create(:option_type, name: "type", presentation: "Duration")
  product_option_type = create(:product_option_type, product: product, option_type: option_type)
  annual_option_value = create(:option_value, name: "annual", presentation: "Annual", option_type: option_type)
  biennal_option_value = create(:option_value, name: "biennal", presentation: "Biennal", option_type: option_type)
  variant1 = create(:variant, product: product, issues_number: 12, option_values: [annual_option_value])
  variant2 = create(:variant, product: product, issues_number: 24, option_values: [biennal_option_value])
  [variant1, variant2]
end