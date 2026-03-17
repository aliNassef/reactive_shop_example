## Architecture

### Goal
Show how product, wishlist, and cart flows can be handled with:
- clean repository abstraction
- reactive update streams
- Cubit state orchestration
- immutable UI state through `ProductState`

### Layers

1. Repositories (`lib/repo`)
   - `ProductsRepo`: product list API / mock data
   - `WishlistRepo`: wishlist state with stream
   - `CartRepo`: cart state with stream
   - Repos expose `Stream<List<...>>` + toggle methods for events

2. Controller (`lib/controller/product_cubit`)
   - `ProductCubit`: loads products, listens repository streams, emits product+ids combined state
   - `ProductState`: holds products, `wishlistedIds`, and `cartedIds`

3. UI (`lib/views`, `lib/widgets`)
   - subscribes to `ProductCubit` state
   - renders product list, wishlist badges, cart icons
   - invokes `toggleWishlist`, `toggleCart`

### Scenario

1. app starts → `ProductCubit.getProducts()` fetches initial products from `ProductsRepo`
2. cubit subscribes to `WishlistRepo.wishlistStream` and `CartRepo.cartItemsStream`
3. user toggles a product
   - data update via repo toggle method
   - repo emits updated list through BehaviorSubject stream
   - cubit receives update, maps IDs, emits new state
4. UI updates as state changes:
   - highlighted wishlist items
   - cart badge counts

### Why BehaviorSubject

- BehaviorSubject (or equivalent) always emits latest current value to new subscribers
- ensures UI gets current wishlist/cart without waiting for next event
- supports both:
  - initial state for screen entry
  - incremental updates on user actions
- good for EDA-like flow where state+events are decoupled
