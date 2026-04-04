use proc_macro::TokenStream;
use quote::quote;

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
    let enumeration = match syn::parse::<syn::ItemEnum>(item) {
        Ok(e) => e,
        Err(_) => {
            return syn::Error::new(proc_macro2::Span::call_site(), "json_tag can only be applied to enums")
                .to_compile_error()
                .into();
        }
    };

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
