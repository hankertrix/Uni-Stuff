// The module containing all the utility functions

/// The macro to dispatch a function for all enum variants
macro_rules! enum_dispatch {
    (
        $match_variable:expr,
        $enum_name:ident,
        $($enum_variants:ident),*,
        |$enum_variant_obj:ident| $body:block
    ) => {
        //

        // Match the given variable to all of the enum variants
        match $match_variable {
            //

            // Run the body of the "closure" given
            // for all enum variants.
            $(
                $enum_name::$enum_variants($enum_variant_obj) => $body
            )*
        }
    };
}

pub(crate) use enum_dispatch;
