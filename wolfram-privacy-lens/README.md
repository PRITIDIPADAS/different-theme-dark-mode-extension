# Privacy Lens

Privacy Lens is a Wolfram Language prototype for reviewing browser cookie metadata.

It checks five things: Secure, HttpOnly, SameSite, third party use, and cookie lifetime. Each cookie receives a transparent score and a list of findings. It also gives examples of software alternatives by category.

The records in the notebook are fictional. The project does not read a live browser profile, send cookie data anywhere, or query a breach database. The score is a simple screening rule, not proof that a cookie is safe or unsafe.

To run it, open a blank notebook in Wolfram Cloud, paste the contents of `PrivacyLens.wl` into an input cell, and evaluate it. Publish the notebook with public viewing enabled before sharing its link.

The next stage would be a browser extension that reads cookie metadata only after the user grants permission. A breach lookup would need a separate design that avoids sending passwords or other sensitive data to a third party.
