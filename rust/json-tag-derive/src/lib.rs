use proc_macro::TokenStream;
use quote::quote;
use syn::parse_macro_input;

/// Attribute macro that configures a Rust enum for JSON Tag serialization.
///
/// Injects `#[serde(tag = "#type")]` on the enum.
///
/// Must be placed before `#[derive(Serialize, Deserialize)]`.
///
/// # Example
///
/// ```ignore
/// #[json_tag]
/// #[derive(Serialize, Deserialize)]
/// enum Shape {
///     Circle { radius: f64 },
///     Rectangle { width: f64, height: f64 },
/// }
/// ```
#[proc_macro_attribute]
pub fn json_tag(_attribute: TokenStream, item: TokenStream) -> TokenStream {
    let enumeration = parse_macro_input!(item as syn::ItemEnum);

    let attributes = &enumeration.attrs;
    let visibility = &enumeration.vis;
    let name = &enumeration.ident;
    let generics = &enumeration.generics;
    let variants = &enumeration.variants;

    let output = quote! {
        #(#attributes)*
        #[serde(tag = "#type")]
        #visibility enum #name #generics {
            #variants
        }
    };

    output.into()
}
