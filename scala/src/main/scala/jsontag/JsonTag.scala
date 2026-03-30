package jsontag

/// uPickle instance configured with #type as the discriminator.
/// Use `JsonTag.read` and `JsonTag.write` instead of `upickle.default`.
object JsonTag extends upickle.AttributeTagged:
  override def tagName = "#type"
