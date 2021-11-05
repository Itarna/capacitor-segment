# Capacitor Segment Plugin

The plugin enables segment analytics tracking for ionic apps

## Install

```bash
npm install @payflow-chile/capacitor-segment
npx cap sync
```

## API

<docgen-index>

* [`initialize(...)`](#initialize)
* [`identify(...)`](#identify)
* [`track(...)`](#track)
* [`screen(...)`](#screen)
* [`page(...)`](#page)
* [`group(...)`](#group)
* [`alias(...)`](#alias)
* [`reset()`](#reset)
* [Interfaces](#interfaces)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### initialize(...)

```typescript
initialize(args: InitializeArguments) => any
```

Configures and initializes the segment plugin

| Param      | Type                                                                |
| ---------- | ------------------------------------------------------------------- |
| **`args`** | <code><a href="#initializearguments">InitializeArguments</a></code> |

**Returns:** <code>any</code>

--------------------


### identify(...)

```typescript
identify(args: IdentifyArguments) => any
```

Identify a user.

| Param      | Type                                                            |
| ---------- | --------------------------------------------------------------- |
| **`args`** | <code><a href="#identifyarguments">IdentifyArguments</a></code> |

**Returns:** <code>any</code>

--------------------


### track(...)

```typescript
track(args: TrackArguments) => any
```

Track an event.

| Param      | Type                                                      |
| ---------- | --------------------------------------------------------- |
| **`args`** | <code><a href="#trackarguments">TrackArguments</a></code> |

**Returns:** <code>any</code>

--------------------


### screen(...)

```typescript
screen(args: ScreenArguments) => any
```

Trigger screen view.

| Param      | Type                                                        |
| ---------- | ----------------------------------------------------------- |
| **`args`** | <code><a href="#screenarguments">ScreenArguments</a></code> |

**Returns:** <code>any</code>

--------------------


### page(...)

```typescript
page(args: PageArguments) => any
```

Trigger page view.

| Param      | Type                                                    |
| ---------- | ------------------------------------------------------- |
| **`args`** | <code><a href="#pagearguments">PageArguments</a></code> |

**Returns:** <code>any</code>

--------------------


### group(...)

```typescript
group(options: GroupArguments) => any
```

Clear all information about the visitor & reset analytic state.

| Param         | Type                                                      |
| ------------- | --------------------------------------------------------- |
| **`options`** | <code><a href="#grouparguments">GroupArguments</a></code> |

**Returns:** <code>any</code>

--------------------


### alias(...)

```typescript
alias(options: AliasArguments) => any
```

Clear all information about the visitor & reset analytic state.

| Param         | Type                                                      |
| ------------- | --------------------------------------------------------- |
| **`options`** | <code><a href="#aliasarguments">AliasArguments</a></code> |

**Returns:** <code>any</code>

--------------------


### reset()

```typescript
reset() => any
```

clears the SDK’s internal stores for the current user and group.

**Returns:** <code>any</code>

--------------------


### Interfaces


#### InitializeArguments

| Prop                       | Type                 |
| -------------------------- | -------------------- |
| **`writeKey`**             | <code>string</code>  |
| **`trackLifecycleEvents`** | <code>boolean</code> |
| **`recordScreenViews`**    | <code>boolean</code> |


#### IdentifyArguments

| Prop          | Type                |
| ------------- | ------------------- |
| **`userId`**  | <code>string</code> |
| **`traits`**  | <code>any</code>    |
| **`options`** | <code>any</code>    |


#### TrackArguments

| Prop             | Type                |
| ---------------- | ------------------- |
| **`eventName`**  | <code>string</code> |
| **`properties`** | <code>any</code>    |
| **`options`**    | <code>any</code>    |


#### ScreenArguments

| Prop             | Type                |
| ---------------- | ------------------- |
| **`screenName`** | <code>string</code> |
| **`category`**   | <code>string</code> |
| **`properties`** | <code>any</code>    |
| **`options`**    | <code>any</code>    |


#### PageArguments

| Prop             | Type                |
| ---------------- | ------------------- |
| **`pageName`**   | <code>string</code> |
| **`category`**   | <code>string</code> |
| **`properties`** | <code>any</code>    |
| **`options`**    | <code>any</code>    |


#### GroupArguments

| Prop          | Type                |
| ------------- | ------------------- |
| **`userId`**  | <code>string</code> |
| **`groupId`** | <code>string</code> |
| **`traits`**  | <code>any</code>    |
| **`options`** | <code>any</code>    |


#### AliasArguments

| Prop          | Type                |
| ------------- | ------------------- |
| **`newId`**   | <code>string</code> |
| **`options`** | <code>any</code>    |

</docgen-api>
