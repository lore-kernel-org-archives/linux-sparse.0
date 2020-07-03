From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] manpage: annotations
Date: Fri,  3 Jul 2020 02:04:54 +0200
Message-ID: <20200703000454.55816-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgGCAFA (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 2 Jul 2020 20:05:00 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B5AC08C5C1
        for <linux-sparse@vger.kernel.org>; Thu,  2 Jul 2020 17:04:59 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id rk21so31941321ejb.2
        for <linux-sparse@vger.kernel.org>; Thu, 02 Jul 2020 17:04:59 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 sparse.1 | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/sparse.1 b/sparse.1
index d916ad9ee54e..068764799e00 100644
--- a/sparse.1
+++ b/sparse.1
@@ -18,6 +18,65 @@ option \fB\-Wsomething\fR.  Sparse issues some warnings by default; to turn
 off those warnings, pass the negation of the associated warning option,
 \fB\-Wno\-something\fR.
 .
+.SH ANNOTATIONS
+Sparse extends C's type system with a number of extra type qualifiers
+adding restrictions on what you can do on objects annotated with them.
+These qualifiers are specified with GCC's \fB__attribute__\fR syntax:
+.IP - 2
+bitwise
+.RS 2
+This attribute is to be used to define new, unique integer types that
+cannot be mixed with other types.
+In particular, you can't mix a "bitwise" integer with a normal integer
+expression, and in fact you can't even mix it with another bitwise
+expression of a different type.
+The integer 0 is special, though, and can be mixed with any bitwise type
+since it's safe for all bitwise operations.
+
+Since this qualifier defines new types, it only makes sense to use
+it in typedefs, which effectively makes each of these typedefs
+a single "bitwise class", incompatible with any other types.
+.RE
+.IP - 2
+force
+.RS 2
+This attribute is to be used in casts to suppress warnings that
+would be otherwise caused by this cast because of the presence of
+one of these qualifiers.
+.RE
+.IP - 2
+noderef
+.RS 2
+This attribute is to be used on a r-value to specify it cannot be
+dereferenced. A pointer so annotated is in all other aspects exactly
+like a pointer in all other respects, but trying to actually access
+anything through it will cause a warning.
+.RE
+.IP - 2
+address_space(\fIname\fR)
+.RS 2
+.RE
+.IP - 2
+context(\fIcontext\fR, \fIin\fR, \fIout\fR)
+.RS 2
+.RE
+.IP - 2
+nocast
+.RS 2
+This attribute is similar to \fBbitwise\fR but in a much weaker form.
+It is also 
+__nocast warns about explicit or implicit casting to different types
+however, the __nocast attribute disables many of the implicit type conversions
+
+.RE
+.IP - 2
+safe
+.RS 2
+This attribute specifies that the object, which should be a pointer,
+is defined to never be NULL or nontrapping.
+It causes a warning if the object is tested in a conditional.
+.RE
+
 .SH WARNING OPTIONS
 .TP
 .B \-fmax-warnings=COUNT
-- 
2.27.0
