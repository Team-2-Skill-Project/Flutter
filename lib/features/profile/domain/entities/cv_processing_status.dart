/// Backend-documented CV processing states plus a safe fallback.
///
/// The string-to-enum mapping is applied inside the Data Layer
/// (`CvDocumentModel`): `processing` → [analyzing],
/// `completed` → [analyzed], `failed` → [failed].
/// Anything else (including legacy cached values such as `uploaded`)
/// maps to [unknown], which renders without a status badge.
/// Presentation resolves labels through `S`
/// (`analyzing`, `analyzed`, `failed`) and must never
/// depend on raw backend machine strings.
enum CvProcessingStatus { analyzing, analyzed, failed, unknown }
